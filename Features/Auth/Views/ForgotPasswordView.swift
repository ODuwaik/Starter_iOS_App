import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var viewModel = AuthViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Forgot Password")
                .font(.largeTitle)
                .bold()
            
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Button {
                Task {
                    await viewModel.resetPassword()
                }
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("Reset Password")
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .disabled(viewModel.isLoading)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Forgot Password")
        .alert("Password Reset", isPresented: .constant(viewModel.errorMessage == "Password reset email sent")) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Check your email for instructions to reset your password.")
        }
    }
}
