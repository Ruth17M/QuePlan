//
//  FilterSheetView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct FilterSheetView: View {
    @State private var minRating: Double = 1.5
    @State private var maxPrice: Double = 1000
    @Environment(\.dismiss) var dismiss
 
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
 
            // Handle
            Capsule()
                .fill(Color.appGrayMid)
                .frame(width: 40, height: 4)
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
 
            // Encabezado
            HStack {
                Text("Filtros")
                    .font(.system(size: 20, weight: .bold))
                Spacer()
                Button("Restablecer") {
                    minRating = 0; maxPrice = 1000
                }
                .font(.system(size: 14))
                .foregroundColor(.appTextSecondary)
            }
            .padding(.horizontal)
            .padding(.vertical, 16)
 
            Divider()
 
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 32) {
 
                    // Calificación mínima
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Calificación mínima")
                            .font(.system(size: 16, weight: .semibold))
                        HStack(spacing: 12) {
                            Slider(value: $minRating, in: 0...5, step: 0.5)
                                .tint(.appPink)
                            Text(String(format: "%.1f ★", minRating))
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.appTextSecondary)
                                .frame(width: 54, alignment: .trailing)
                        }
                    }
 
                    Divider()
 
                    // Tarifa máxima
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Tarifa máxima")
                            .font(.system(size: 16, weight: .semibold))
                        HStack(spacing: 12) {
                            Slider(value: $maxPrice, in: 0...5000, step: 100)
                                .tint(.appPink)
                            Text("$\(Int(maxPrice))")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.appTextSecondary)
                                .frame(width: 60, alignment: .trailing)
                        }
                    }
                }
                .padding()
            }
 
            Spacer()
 
            PrimaryButton(title: "Aplicar filtros") { dismiss() }
                .padding()
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.hidden)
    }
}
