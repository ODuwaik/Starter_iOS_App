//
//  OnboardingContainerView.swift
//  StarterApp
//
//  Created by Osama N. AlDuwaik on 12/01/2025.
//

import SwiftUI

struct OnboardingContainerView: View {
    @StateObject private var languageManager = LanguageManager.shared
    @StateObject private var onboardingManager = OnboardingManager.shared
    @State private var currentPage = 0
    
    var body: some View {
        ZStack {
            VStack {
                // Skip button
                HStack {
                    Spacer()
                    Button(action: {
                        onboardingManager.hasCompletedOnboarding = true
                    }) {
                        Text(languageManager.localizedString("Skip"))
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                .padding(.horizontal)
                
                // Page content
                TabView(selection: $currentPage) {
                    OnboardingPage(
                        image: "timer",
                        title: languageManager.localizedString("onboarding_title_1"),
                        description: languageManager.localizedString("onboarding_desc_1")
                    )
                    .tag(0)
                    
                    OnboardingPage(
                        image: "globe",
                        title: languageManager.localizedString("onboarding_title_2"),
                        description: languageManager.localizedString("onboarding_desc_2")
                    )
                    .tag(1)
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                // Get Started button
                Button(action: {
                    if currentPage == 0 {
                        withAnimation {
                            currentPage = 1
                        }
                    } else {
                        onboardingManager.hasCompletedOnboarding = true
                        // Navigate to SignInView
                        // Assuming you have a NavigationView and a NavigationLink to SignInView
                        // If not, you can use a presentation modifier or a sheet to present the SignInView
                        // For example:
                        // NavigationLink(destination: SignInView()) {
                        //     Text(languageManager.localizedString("Get Started"))
                        // }
                    }
                }) {
                    Text(currentPage == 0 ?
                        languageManager.localizedString("Next") :
                        languageManager.localizedString("Get Started"))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.purple]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(25)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
        .environment(\.layoutDirection, languageManager.isRTL ? .rightToLeft : .leftToRight)
    }
}
