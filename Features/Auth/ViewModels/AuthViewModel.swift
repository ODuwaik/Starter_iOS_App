import Foundation
import SwiftUI
import FirebaseAuth
import AuthenticationServices

@MainActor
class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var errorMessage: String? = nil
    @Published var isLoading = false
    
    @Published var isAuthenticated = false
    private let firebase = FirebaseService.shared
    private let onboardingManager = OnboardingManager.shared
    
    init() {
        // Set up publisher for Firebase authentication state
        firebase.$isAuthenticated
            .assign(to: &$isAuthenticated)
    }
    
    private func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func validatePassword() -> Bool {
        // Firebase requires at least 6 characters
        return password.count >= 6
    }
    
    private func validateSignUpInputs() -> String? {
        if !validateEmail() {
            return "Please enter a valid email address"
        }
        
        if !validatePassword() {
            return "Password must be at least 6 characters"
        }
        
        if password != confirmPassword {
            return "Passwords do not match"
        }
        
        return nil
    }
    
    private func validateSignInInputs() -> String? {
        if email.isEmpty || password.isEmpty {
            return "Please fill in all fields"
        }
        
        if !validateEmail() {
            return "Please enter a valid email address"
        }
        
        return nil
    }
    
    func signIn() async {
        if let validationError = validateSignInInputs() {
            errorMessage = validationError
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            try await firebase.signIn(email: email, password: password)
            isAuthenticated = true
        } catch let error as NSError {
            if error.domain == NSURLErrorDomain {
                errorMessage = "Network error. Please check your connection and try again."
            } else {
                errorMessage = "Invalid email or password. Please try again."
            }
        } catch {
            errorMessage = "An unexpected error occurred. Please try again."
        }
        
        isLoading = false
    }
    
    func signUp() async {
        isLoading = true
        errorMessage = nil
        
        if let validationError = validateSignUpInputs() {
            errorMessage = validationError
            isLoading = false
            return
        }
        
        do {
            try await firebase.signUp(email: email, password: password)
            isAuthenticated = true
        } catch let error as NSError {
            if error.domain == AuthErrorDomain {
                switch error.code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    errorMessage = "Email is already in use. Please sign in or use a different email."
                case AuthErrorCode.invalidEmail.rawValue:
                    errorMessage = "Please enter a valid email address."
                case AuthErrorCode.weakPassword.rawValue:
                    errorMessage = "Password is too weak. Please use at least 6 characters."
                default:
                    errorMessage = error.localizedDescription
                }
            } else {
                errorMessage = error.localizedDescription
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func resetPassword() async {
        isLoading = true
        errorMessage = nil
        
        if !validateEmail() {
            errorMessage = "Please enter a valid email address"
            isLoading = false
            return
        }
        
        do {
            try await firebase.resetPassword(email: email)
            errorMessage = "Password reset email sent"
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func signOut() {
        do {
            try firebase.signOut()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func deleteAccount() async {
        isLoading = true
        do {
            try await firebase.deleteAccount()
            print("Account deleted successfully")
        } catch {
            print("Error deleting account: \(error)")
            errorMessage = "Failed to delete account: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func signInWithApple(credential: ASAuthorizationAppleIDCredential) async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await firebase.signInWithApple(credential: credential)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func continueAsGuest() {
        isAuthenticated = true
    }
}
