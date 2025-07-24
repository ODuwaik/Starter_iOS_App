import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
            Text("Sign In")
                .font(.largeTitle)
                .bold()

            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)

            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)

            NavigationLink("Forgot Password?", destination: ForgotPasswordView())
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(.blue)

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            Button {
                Task {
                    await viewModel.signIn()
                }
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("Sign In")
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .disabled(viewModel.isLoading)

            // Apple Sign In Button
            SignInWithAppleButton(.signIn, onRequest: { request in
                request.requestedScopes = [.email, .fullName]
            }, onCompletion: { result in
                switch result {
                case .success(let authResults):
                    guard let appleIDCredential = authResults.credential as? ASAuthorizationAppleIDCredential else {
                        print("Unable to get Apple ID credentials")
                        return
                    }
                    Task {
                        await viewModel.signInWithApple(credential: appleIDCredential)
                    }
                case .failure(let error):
                    print("Apple Sign In Error: \(error.localizedDescription)")
                }
            })
            .frame(height: 50)
            .cornerRadius(8)
            .padding(.vertical)
            
            NavigationLink("Don't have an account? Sign Up", destination: SignUpView())
                .font(.footnote)

            Button {
                viewModel.continueAsGuest()
            } label: {
                Text("Continue as Guest")
                    .foregroundColor(.blue)
                    .padding(.top, 16)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("")
        .navigationBarHidden(true)
        // Remove fullScreenCover since main app handles auth state
        }
    }
}

// Native TextField using UIKit
struct NativeTextField: UIViewRepresentable {
    @Binding var text: String
    let placeholder: String
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: UITextAutocapitalizationType = .sentences
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        textField.autocapitalizationType = autocapitalization
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}

// Native Secure TextField using UIKit
struct NativeSecureField: UIViewRepresentable {
    @Binding var text: String
    let placeholder: String
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}


