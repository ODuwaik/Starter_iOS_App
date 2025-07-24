import Foundation
import FirebaseCore
import FirebaseAuth

class FirebaseTest {
    static func testConfiguration() {
        print("\n=== FIREBASE CONFIGURATION TEST ===\n")
        
        // Check if Firebase is initialized
        if FirebaseApp.app() != nil {
            print("✅ SUCCESS: Firebase is properly initialized")
        } else {
            print("❌ ERROR: Firebase is not initialized")
        }
        
        // Check if we can access Auth
        if Auth.auth() != nil {
            print("✅ SUCCESS: Firebase Auth is accessible")
        } else {
            print("❌ ERROR: Firebase Auth is not accessible")
        }
        
        // Print current user if any
        if let user = Auth.auth().currentUser {
            print("\n👤 CURRENT USER INFORMATION:")
            print("   • UID: \(user.uid)")
            print("   • Email: \(user.email ?? "No email")")
            print("   • Display Name: \(user.displayName ?? "No name")")
            print("   • Email Verified: \(user.isEmailVerified ? "Yes" : "No")")
        } else {
            print("\nℹ️ STATUS: No user currently signed in")
        }
        
        print("\n=== TEST COMPLETE ===\n")
    }
}
