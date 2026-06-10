//
//  ExperienceCard.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct ExperienceCard: View {
    var title: String = "Pinta tu Totebag"
    var price: String = "$$"
    var rating: Double = 4.7
    var imageName: String? = nil
 
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.pink.opacity(0.25))
                .frame(height: 200)
 
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.55)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: 200)
 
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.white)
                HStack(spacing: 4) {
                    Text(price)
                        .font(.system(size: 13))
                    Image(systemName: "star.fill")
                        .font(.system(size: 11))
                    Text(String(format: "%.1f", rating))
                        .font(.system(size: 13))
                }
                .foregroundColor(.white.opacity(0.9))
            }
            .padding(14)
        }
        .frame(maxWidth: .infinity)
    }
}
 
