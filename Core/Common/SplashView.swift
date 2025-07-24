//
//  SplashView.swift
//  StarterApp
//
//  Created by Osama N. AlDuwaik on 12/01/2025.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @StateObject private var onboardingManager = OnboardingManager.shared
    @StateObject private var languageManager = LanguageManager.shared
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        if isActive {
            if !onboardingManager.hasCompletedOnboarding {
                OnboardingContainerView()
                    .environmentObject(authViewModel)
            } else if !authViewModel.isAuthenticated {
                NavigationView {
                    SignInView()
                }
            } else {
                MainTabView()
            }
        } else {
            // Splash Screen
            VStack {
                Image(systemName: "globe")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                
                Text("BilingualApp")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}
