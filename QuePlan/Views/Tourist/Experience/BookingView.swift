//
//  BookingView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI


struct BookingView: View {
    @State private var selectedSlot = "12:00"
    @State private var people = 1
    @Environment(\.dismiss) var dismiss
 
    private let slots = ["9:00", "12:00", "15:00"]
 
    var body: some View {
        VStack(spacing: 0) {
 
            // Mini hero
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .fill(Color.pink.opacity(0.28))
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
 
                VStack(alignment: .leading, spacing: 2) {
                    Text("Pinta tu Totebag")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    HStack(spacing: 4) {
                        Text("$$$  ·")
                        Image(systemName: "star.fill").font(.system(size: 11))
                        Text("4.3")
                    }
                    .font(.system(size: 13))
                    .foregroundColor(.white)
                }
                .padding(14)
 
                IconButton(
                    systemName: "xmark.circle.fill",
                    size: 32,
                    iconSize: 24,
                    foregroundColor: .white
                ) { dismiss() }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(12)
            }
 
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
 
                    Text("Asegura tu lugar")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.appPink)
                        .frame(maxWidth: .infinity)
 
                    Text("Detalles")
                        .font(.system(size: 16, weight: .semibold))
 
                    // Fecha
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 6) {
                            Image(systemName: "calendar").foregroundColor(.appPink)
                            Text("Fecha")
                                .font(.system(size: 13))
                                .foregroundColor(.appTextSecondary)
                        }
                        Text("14/03/2026").font(.system(size: 15))
                    }
 
                    // Horario
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Horario")
                            .font(.system(size: 13))
                            .foregroundColor(.appTextSecondary)
                        HStack(spacing: 10) {
                            ForEach(slots, id: \.self) { slot in
                                Button { selectedSlot = slot } label: {
                                    Text(slot)
                                        .font(.system(size: 14, weight: .medium))
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 9)
                                        .background(selectedSlot == slot ? Color.appPink : Color.white)
                                        .foregroundColor(selectedSlot == slot ? .white : .appTextPrimary)
                                        .cornerRadius(20)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.appGrayMid, lineWidth: 1)
                                        )
                                }
                            }
                        }
                    }
 
                    // Número de personas
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Número de personas")
                            .font(.system(size: 13))
                            .foregroundColor(.appTextSecondary)
                        HStack(spacing: 20) {
                            Button {
                                if people > 1 { people -= 1 }
                            } label: {
                                Image(systemName: "minus.circle")
                                    .font(.system(size: 28))
                                    .foregroundColor(Color.appGrayMid)
                            }
                            Text("\(people)")
                                .font(.system(size: 20, weight: .semibold))
                                .frame(width: 28, alignment: .center)
                            Button { people += 1 } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 28))
                                    .foregroundColor(.appPink)
                            }
                        }
                    }
                }
                .padding()
            }
 
            // Botones footer
            VStack(spacing: 10) {
                PrimaryButton(title: "Continuar") { dismiss() }
                Button("Cancelar") { dismiss() }
                    .font(.system(size: 15))
                    .foregroundColor(.appTextSecondary)
            }
            .padding()
        }
        .ignoresSafeArea(edges: .top)
    }
}
