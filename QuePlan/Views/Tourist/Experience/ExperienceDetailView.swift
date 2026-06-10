//
//  ExperienceDetailView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

import SwiftUI

struct ExperienceDetailView: View {
    @State private var showBooking = false
    @State private var isFavorite = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {

                // Hero con overlay degradado
                ZStack(alignment: .bottomLeading) {
                    Rectangle()
                        .fill(Color.pink.opacity(0.3))
                        .frame(maxWidth: .infinity)
                        .frame(height: 280)

                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [.clear, .black.opacity(0.52)],
                                startPoint: .top, endPoint: .bottom
                            )
                        )
                        .frame(height: 280)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Pinta tu Totebag")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        HStack(spacing: 4) {
                            Text("$$$  ·")
                            Image(systemName: "star.fill").font(.system(size: 12))
                            Text("4.3")
                        }
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                    }
                    .padding(16)

                    IconButton(
                        systemName: "xmark.circle.fill",
                        size: 36,
                        iconSize: 26,
                        foregroundColor: .white
                    ) { dismiss() }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(12)
                }

                // Contenido
                VStack(alignment: .leading, spacing: 18) {

                    HStack {
                        Text("Pinta tu Totebag")
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                        IconButton(systemName: "star", iconSize: 20)
                        IconButton(
                            systemName: isFavorite ? "heart.fill" : "heart",
                            iconSize: 20,
                            foregroundColor: .appPink
                        ) { isFavorite.toggle() }
                    }

                    Text("Si buscas un ambiente relajado, esta cafetería organiza frecuentemente actividades creativas como pintura donde puedes disfrutar de una bebida mientras elaboras tus manualidades.")
                        .font(.system(size: 14))
                        .foregroundColor(.appTextSecondary)
                        .lineSpacing(4)

                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.appPink)
                            .font(.system(size: 18))
                        Text("Blvd. Miguel de Cervantes Saavedra, Granada, Miguel Hidalgo, 11529 Ciudad de México, CDMX")
                            .font(.system(size: 14))
                            .foregroundColor(.appTextSecondary)
                    }

                    HStack(spacing: 10) {
                        ForEach(0..<2, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.appGray)
                                .frame(height: 110)
                        }
                    }

                    PrimaryButton(title: "Quiero inscribirme") { showBooking = true }

                    Text("Opiniones")
                        .font(.system(size: 18, weight: .bold))

                    // ✅ FIX: usar 'index' en lugar de mezclar _ con $0
                    ForEach(0..<3, id: \.self) { index in
                        ReviewRow()
                        if index < 2 { Divider() }
                    }
                }
                .padding(16)
                .padding(.bottom, 30)
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarHidden(true)
        .sheet(isPresented: $showBooking) { BookingView() }
    }
}

#Preview { ExperienceDetailView() }
