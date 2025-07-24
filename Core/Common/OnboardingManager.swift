//
//  OnboardingManager.swift
//  StarterApp
//
//  Created by Osama N. AlDuwaik on 12/01/2025.
//

import Foundation
import SwiftUI

class OnboardingManager: ObservableObject {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
    
    static let shared = OnboardingManager()
    private init() {
        hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    }
    
    func resetAllStates() {
        hasCompletedOnboarding = false
    }
}
