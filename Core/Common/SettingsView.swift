//
//  SettingsView.swift
//  StarterApp
//
//  Created by Osama N. AlDuwaik on 12/01/2025.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @StateObject private var languageManager = LanguageManager.shared
    @StateObject private var authViewModel = AuthViewModel()
    @State private var showingLanguageAlert = false
    @State private var selectedLanguage: String?
    @State private var showDeleteConfirmation = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text(languageManager.localizedString("Language"))) {
                    // English Option
                    Button(action: {
                        if languageManager.appLanguage != "en" {
                            selectedLanguage = "en"
                            showingLanguageAlert = true
                        }
                    }) {
                        HStack {
                            Text("English")
                                .foregroundColor(.primary)
                            Spacer()
                            if languageManager.appLanguage == "en" {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    
                    // Arabic Option
                    Button(action: {
                        if languageManager.appLanguage != "ar" {
                            selectedLanguage = "ar"
                            showingLanguageAlert = true
                        }
                    }) {
                        HStack {
                            Text("العربية")
                                .foregroundColor(.primary)
                            Spacer()
                            if languageManager.appLanguage == "ar" {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        Task {
                            await authViewModel.signOut()
                        }
                    }) {
                        HStack {
                            Text("Sign Out")
                                .foregroundColor(.red)
                            Spacer()
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.red)
                        }
                    }
                    
                    Button(action: {
                        showDeleteConfirmation = true
                    }) {
                        HStack {
                            Text("Delete Account")
                                .foregroundColor(.red)
                            Spacer()
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                    .alert("Delete Account", isPresented: $showDeleteConfirmation) {
                        Button("Cancel", role: .cancel) { }
                        Button("Delete", role: .destructive) {
                            Task {
                                await authViewModel.deleteAccount()
                            }
                        }
                    } message: {
                        Text("Are you sure you want to delete your account? This action cannot be undone.")
                    }
                }
            }
            .navigationTitle(languageManager.localizedString("Settings"))
            .alert("Change Language", isPresented: $showingLanguageAlert) {
                Button("Cancel", role: .cancel) {
                    selectedLanguage = nil
                }
                Button("Change") {
                    if let language = selectedLanguage {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            languageManager.setLanguage(language)
                        }
                    }
                }
            } message: {
                Text("The app will shut down to change the language. Please reopen the app to see the changes.")
            }
        }
        .environment(\.layoutDirection, languageManager.isRTL ? .rightToLeft : .leftToRight)
        .onChange(of: authViewModel.isAuthenticated) { isAuthenticated in
            if !isAuthenticated {
                dismiss()
            }
        }
    }
}
