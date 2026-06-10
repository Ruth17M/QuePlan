//
//  EditableAvatarView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct EditableAvatarView: View {
    var size: CGFloat = 100
    var onTap: () -> Void = {}
 
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            AvatarView(size: size, showBorder: true)
            Button(action: onTap) {
                Circle()
                    .fill(Color.appPink)
                    .frame(width: size * 0.32, height: size * 0.32)
                    .overlay(
                        Image(systemName: "pencil")
                            .font(.system(size: size * 0.14, weight: .medium))
                            .foregroundColor(.white)
                    )
            }
            .offset(x: 4, y: 4)
        }
    }
}
 
