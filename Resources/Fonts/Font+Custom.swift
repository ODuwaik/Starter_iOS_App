//
//  Font+Custom.swift
//  StarterApp
//
//  Created by Osama N. AlDuwaik on 11/05/2025.
//

import SwiftUI

extension Font {
    static func arabicFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        let fontName: String

        switch weight {
        case .bold:
            fontName = "BalooBhaijaan2-Bold"
        case .semibold:
            fontName = "BalooBhaijaan2-SemiBold"
        case .medium:
            fontName = "BalooBhaijaan2-Medium"
        case .regular:
            fontName = "BalooBhaijaan2-Regular"
        case .heavy, .black:
            fontName = "BalooBhaijaan2-ExtraBold"
        default:
            fontName = "BalooBhaijaan2-Regular"
        }

        return Font.custom(fontName, size: size)
    }
}

struct LocalizedFontModifier: ViewModifier {
    var size: CGFloat
    var weight: Font.Weight

    func body(content: Content) -> some View {
        let lang = LanguageManager.shared.getCurrentLanguage()
        let font: Font = lang == "ar" ?
            .arabicFont(size: size, weight: weight) :
            .system(size: size, weight: weight)
        
        return content.font(font)
    }
}

extension View {
    func localizedFont(size: CGFloat, weight: Font.Weight = .regular) -> some View {
        self.modifier(LocalizedFontModifier(size: size, weight: weight))
    }
}
