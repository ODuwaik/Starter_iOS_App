//
//  LanguageManager.swift
//  StarterApp
//
//  Created by Osama N. AlDuwaik on 12/01/2025.
//

import Foundation
import SwiftUI
import UIKit

class LanguageManager: ObservableObject {
    @AppStorage("appLanguage") var appLanguage: String = LanguageManager.getInitialLanguage()
    @Published var viewID = UUID()
    
    static let shared = LanguageManager()
    
    private init() {
        // Set initial language if not already set
        if UserDefaults.standard.string(forKey: "appLanguage") == nil {
            appLanguage = LanguageManager.getInitialLanguage()
            UserDefaults.standard.set([appLanguage], forKey: "AppleLanguages")
        }
    }
    
    static func getInitialLanguage() -> String {
        // Get the system language
        let systemLanguage = Locale.current.language.languageCode?.identifier ?? "en"
        
        // Check if the system language is supported (we support en and ar)
        // You can extend this list for more supported languages
        return systemLanguage == "ar" ? "ar" : "en"
    }
    
    var isRTL: Bool {
        return appLanguage == "ar"
    }
    
    func getCurrentLanguage() -> String {
        return appLanguage
    }
    
    func setLanguage(_ language: String) {
        appLanguage = language
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        exit(0)
    }
    
    func localizedString(_ key: String) -> String {
        let language = getCurrentLanguage()
        if let bundlePath = Bundle.main.path(forResource: language, ofType: "lproj"),
           let bundle = Bundle(path: bundlePath) {
            return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
        }
        return NSLocalizedString(key, comment: "")
    }
}
