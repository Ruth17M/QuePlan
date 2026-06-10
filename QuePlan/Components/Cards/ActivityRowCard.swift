//
//  ActivityRowCard.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI


struct ActivityRowCard: View {
    var title: String = "Pinta tu Tote"
    var capacity: Int = 30
    var time: String = "16:00 hrs"
 
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.appTextPrimary)
                Text("Cupo: \(capacity) personas")
                    .font(.system(size: 13))
                    .foregroundColor(.appTextSecondary)
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.system(size: 11))
                        .foregroundColor(.appPink)
                    Text(time)
                        .font(.system(size: 13))
                        .foregroundColor(.appPink)
                }
            }
            Spacer()
            Button {} label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.appTextSecondary)
                    .rotationEffect(.degrees(90))
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 2)
    }
}
