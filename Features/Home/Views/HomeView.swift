//
//  HomeView.swift.swift
//  StarterApp
//
//  Created by Osama N. AlDuwaik on 12/01/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var languageManager = LanguageManager.shared
    
    var body: some View {
        MainHomeView()
        .environment(\.layoutDirection, languageManager.isRTL ? .rightToLeft : .leftToRight)
        .id(languageManager.viewID)
    }
}
