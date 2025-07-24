//
//  LanguageSelectorView.swift
//  StarterApp
//
//  Created by Osama N. AlDuwaik on 12/01/2025.
//

import SwiftUI

struct LanguageSelectorView: View {
    @StateObject private var languageManager = LanguageManager.shared
    @State private var showingLanguageAlert = false
    @State private var selectedLanguage: String?
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "globe")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .foregroundColor(.blue)
            
            Text("Select Your Language")
                .localizedFont(size: 24, weight: .bold)
            
            Text("اختر لغتك")
                .localizedFont(size: 24, weight: .bold)
            
            VStack(spacing: 20) {
                LanguageButton(title: "English", action: {
                    selectedLanguage = "en"
                    showingLanguageAlert = true
                })
                
                LanguageButton(title: "العربية", action: {
                    selectedLanguage = "ar"
                    showingLanguageAlert = true
                })
            }
            .padding(.top, 50)
        }
        .padding()
        .alert("Select Language", isPresented: $showingLanguageAlert) {
            Button("Cancel", role: .cancel) {
                selectedLanguage = nil
            }
            Button("Confirm") {
                if let language = selectedLanguage {
                    UserDefaults.standard.set(true, forKey: "hasSelectedLanguage")
                    UserDefaults.standard.synchronize()
                    languageManager.setLanguage(language) // This will immediately exit the app
                }
            }
        } message: {
            Text("The app will shut down to set the language. Please reopen the app to continue setup.")
        }
    }
}

struct LanguageButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .localizedFont(size: 18, weight: .semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}
