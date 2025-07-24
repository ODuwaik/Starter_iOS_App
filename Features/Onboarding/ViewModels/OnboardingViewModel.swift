import Foundation
import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var currentPage = 0
    
    let pages = [
        OnboardingPage(image: "heart.text.square.fill", title: "onboarding_title_1", description: "onboarding_desc_1"),
        OnboardingPage(image: "globe", title: "onboarding_title_2", description: "onboarding_desc_2")
    ]
    
    func nextPage() {
        if currentPage < pages.count - 1 {
            currentPage += 1
        }
    }
    
    func skipOnboarding() {
        OnboardingManager.shared.hasCompletedOnboarding = true
    }
}
