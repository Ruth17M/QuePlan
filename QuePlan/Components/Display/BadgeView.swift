//
//  BadgeView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct BadgeView: View {
    let text: String
    var backgroundColor: Color = .appPinkLight
    var textColor: Color = .appPink
 
    var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(textColor)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(backgroundColor)
            .cornerRadius(20)
    }
}
