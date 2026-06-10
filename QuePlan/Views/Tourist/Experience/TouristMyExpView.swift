//
//  TouristMyExpView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct TouristMyExpView: View {
    @State private var selectedDay = 2
    @State private var showFullCal = false
 
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
 
                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Hola, Ruth")
                                .font(.system(size: 22, weight: .bold))
                            Text("Descubre, reserva y vive experiencias.")
                                .font(.system(size: 13))
                                .foregroundColor(.appTextSecondary)
                        }
                        Spacer()
                        AvatarView(size: 42)
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
 
                    // Calendario
                    VStack(spacing: 12) {
                        MonthPickerButton()
                            .frame(maxWidth: .infinity, alignment: .leading)
 
                        if showFullCal {
                            MonthCalendarView(selectedDay: $selectedDay)
                        } else {
                            WeekCalendarView(selectedDay: $selectedDay)
                        }
 
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showFullCal.toggle()
                            }
                        } label: {
                            Image(systemName: showFullCal ? "chevron.up" : "chevron.down")
                                .foregroundColor(.appPink)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal)
 
                    // Día seleccionado
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text("15")
                            .font(.system(size: 42, weight: .bold))
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 6) {
                                Text("Dom")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("Hoy")
                                    .font(.system(size: 15))
                                    .foregroundColor(.appTextSecondary)
                            }
                            Text("5 tours programados")
                                .font(.system(size: 13))
                                .foregroundColor(.appTextSecondary)
                        }
                    }
                    .padding(.horizontal)
 
                    Text("Mis actividades")
                        .font(.system(size: 18, weight: .bold))
                        .padding(.horizontal)
 
                    // Scroll horizontal de tarjetas
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(0..<4, id: \.self) { _ in
                                MyExpCard()
                                    .frame(width: 220)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 24)
            }
            .background(Color.white)
        }
    }
}
 
// MARK: - MyExpCard (privado, solo en TouristMyExpView)
private struct MyExpCard: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.2))
                .frame(height: 200)
 
            // Degradado
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.5)],
                        startPoint: .top, endPoint: .bottom
                    )
                )
                .frame(height: 200)
 
            // Corazón top-right
            IconButton(systemName: "heart", iconSize: 16, foregroundColor: .white)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(6)
 
            // Info + "Ver más"
            VStack(alignment: .leading, spacing: 4) {
                Text("Museo Soumaya")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                HStack(spacing: 3) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 11))
                    Text("4.5").font(.system(size: 12))
                }
                .foregroundColor(.white)
 
                HStack {
                    Text("Ver más")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                    Spacer()
                    Circle()
                        .fill(Color.white)
                        .frame(width: 28, height: 28)
                        .overlay(
                            Image(systemName: "chevron.right")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.appTextPrimary)
                        )
                }
            }
            .padding(12)
        }
    }
}
