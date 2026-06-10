//
//  IconButton.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct IconButton: View {
    let systemName: String
    var size: CGFloat = 44
    var iconSize: CGFloat = 18
    var foregroundColor: Color = .appPink
    var backgroundColor: Color = .clear
    var action: () -> Void = {}
 
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: iconSize, weight: .medium))
                .foregroundColor(foregroundColor)
                .frame(width: size, height: size)
                .background(backgroundColor)
                .clipShape(Circle())
        }
    }
}
 
#Preview {
    VStack(spacing: 16) {
        HStack(spacing: 8) {
            BadgeView(text: "$$")
            BadgeView(text: "Disponible", backgroundColor: Color.green.opacity(0.15), textColor: .green)
            BadgeView(text: "Agotado", backgroundColor: Color.red.opacity(0.12), textColor: .red)
        }
        HStack(spacing: 12) {
            IconButton(systemName: "heart", backgroundColor: Color.appGray)
            IconButton(systemName: "pencil", backgroundColor: Color.appGray)
            IconButton(systemName: "xmark", foregroundColor: .white, backgroundColor: Color.appPink)
        }
    }
    .padding()
}
 
