//
//  StarterAppApp.swift
//  StarterApp
//
//  Created by Osama N. AlDuwaik on 06/05/2025.
//

import SwiftUI
import FirebaseCore

@main
struct StarterApp: App {
    init() {
        print("\n=== STARTING APP INITIALIZATION ===")
        FirebaseApp.configure()
        print("Firebase configured")
        FirebaseTest.testConfiguration()
        print("=== APP INITIALIZATION COMPLETE ===\n")
    }
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(authViewModel)
        }
    }
}
