import SwiftUI

struct SignUpView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Sign Up")
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
            
            SecureField("Confirm Password", text: $viewModel.confirmPassword)
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
                    await viewModel.signUp()
                }
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("Sign Up")
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
        .navigationBarBackButtonHidden(false)
        // Remove fullScreenCover since main app handles auth state
    }
}
