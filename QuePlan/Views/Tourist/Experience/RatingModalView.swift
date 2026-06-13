//
//  RatingModalView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct RatingModalView: View {
    @Binding var isPresented: Bool
    var experienceName: String = "..."
    @State private var rating = 0
 
    var body: some View {
        ZStack {
            Color.black.opacity(0.45)
                .ignoresSafeArea()
                .onTapGesture { isPresented = false }
 
            VStack(spacing: 20) {
 
                Text("¿Cómo estuvo tu\nexperiencia con\n\(experienceName)?")
                    .font(.system(size: 18, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.appTextPrimary)
 
                Text("Califica al negocio.")
                    .font(.system(size: 15))
                    .foregroundColor(.appTextSecondary)
 
                InteractiveStarRating(rating: $rating, size: 38)
 
                if rating > 0 {
                    Text("¡Gracias por compartir tu opinión!")
                        .font(.system(size: 14))
                        .foregroundColor(.appTextSecondary)
                        .multilineTextAlignment(.center)
                        .transition(.opacity)
                }
            }
            .padding(32)
            .background(Color.white)
            .cornerRadius(20)
            .padding(.horizontal, 36)
            .animation(.easeInOut(duration: 0.2), value: rating)
        }
    }
}
#Preview("Rating") {
    ZStack {
        Color.appGray.ignoresSafeArea()
        RatingModalView(isPresented: .constant(true), experienceName: "Pinta tu Tote")
    }
}
