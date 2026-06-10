//
//  AvatarView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI


struct AvatarView: View {
    var size: CGFloat = 44
    var showBorder: Bool = true
 
    var body: some View {
        Circle()
            .fill(Color.appGray)
            .frame(width: size, height: size)
            .overlay(
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .padding(size * 0.22)
                    .foregroundColor(.appTextSecondary)
            )
            .overlay(
                Circle()
                    .stroke(showBorder ? Color.appPink : Color.clear, lineWidth: 2)
            )
    }
}
