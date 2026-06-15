//
//  AppColors.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI
import Combine

extension Color {
    static let appPink       = Color(hex: "#E91E8C")
    static let appPinkLight  = Color(hex: "#FBEAF0")
    static let appGray       = Color(hex: "#F4F4F4")
    static let appGrayMid    = Color(hex: "#E0E0E0")
    static let appTextPrimary    = Color(hex: "#1A1A1A")
    static let appTextSecondary  = Color(hex: "#888888")
    static let appBackground = Color.white

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6:  (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:  (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB,
                  red: Double(r)/255,
                  green: Double(g)/255,
                  blue: Double(b)/255,
                  opacity: Double(a)/255)
    }
}
