import Foundation
import FirebaseCore
import FirebaseAuth
import AuthenticationServices
import CryptoKit

class FirebaseService: NSObject, ObservableObject {
    static let shared = FirebaseService()
    
    @Published private(set) var isAuthenticated = false
    
    // Unhashed nonce for Apple Sign In
    private var currentNonce: String?
    
    private override init() {
        super.init()
        
        // Set up auth state listener
        Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
            DispatchQueue.main.async {
                self?.isAuthenticated = user != nil
                if let user = user {
                    print("User is signed in with ID: \(user.uid)")
                    print("Email: \(user.email ?? "No email")")
                    print("Email verified: \(user.isEmailVerified)")
                }
            }
        }
    }
    
    @MainActor
    func signUp(email: String, password: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        isAuthenticated = result.user != nil
    }
    
    @MainActor
    func signIn(email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        isAuthenticated = result.user != nil
    }
    
    @MainActor
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    @MainActor
    func signInWithApple(credential: ASAuthorizationAppleIDCredential) async throws {
        let nonce = randomNonceString()
        
        guard let identityToken = credential.identityToken,
              let tokenString = String(data: identityToken, encoding: .utf8) else {
            throw NSError(domain: "FirebaseService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Could not get identity token"])
        }
        
        let firebaseCredential = OAuthProvider.credential(
            withProviderID: "apple.com",
            idToken: tokenString,
            rawNonce: nonce
        )
        
        let authResult = try await Auth.auth().signIn(with: firebaseCredential)
        isAuthenticated = authResult.user != nil
        
        // Update user profile if this is first sign in
        if let fullName = credential.fullName, let email = credential.email {
            let changeRequest = authResult.user.createProfileChangeRequest()
            changeRequest.displayName = [fullName.givenName, fullName.familyName].compactMap { $0 }.joined(separator: " ")
            try await changeRequest.commitChanges()
            
            print("Updated user profile with name: \(changeRequest.displayName ?? "")")
        }
    }
    
    @MainActor
    func signOut() throws {
        try Auth.auth().signOut()
        isAuthenticated = false
    }
    
    @MainActor
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "FirebaseService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user logged in"])
        }
        
        try await user.delete()
        isAuthenticated = false
    }
    
    // MARK: - Helper Methods
    
    private func performAppleSignIn(request: ASAuthorizationAppleIDRequest) async throws -> ASAuthorization {
        return try await withCheckedThrowingContinuation { continuation in
            let controller = ASAuthorizationController(authorizationRequests: [request])
            let delegate = AppleSignInDelegate(continuation: continuation)
            controller.delegate = delegate
            controller.presentationContextProvider = delegate
            controller.performRequests()
            
            // Store delegate to prevent it from being deallocated
            objc_setAssociatedObject(controller, "delegate", delegate, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}

// MARK: - Apple Sign In Delegate
private class AppleSignInDelegate: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    private let continuation: CheckedContinuation<ASAuthorization, Error>
    
    init(continuation: CheckedContinuation<ASAuthorization, Error>) {
        self.continuation = continuation
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first { $0.isKeyWindow }!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        continuation.resume(returning: authorization)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        continuation.resume(throwing: error)
    }
}
