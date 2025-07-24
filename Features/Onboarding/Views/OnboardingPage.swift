//
//  OnboardingPage.swift
//  StarterApp
//
//  Created by Osama N. AlDuwaik on 12/01/2025.
//

import SwiftUI

struct OnboardingPage: View {
    let image: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Icon
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.blue)
                .padding(.bottom, 50)
            
            // Title
            Text(title)
                .font(.system(size: 32, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // Description
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal, 32)
                .padding(.top, 8)
            
            Spacer()
        }
        .padding()
    }
}
