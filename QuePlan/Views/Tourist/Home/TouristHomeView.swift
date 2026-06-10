//
//  TouristHomeView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct TouristHomeView: View {
    @State private var searchText = ""
    @State private var showFilter = false
 
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
 
                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Hola, Ruth")
                                .font(.system(size: 24, weight: .bold))
                            Text("Descubre, reserva y vive experiencias.")
                                .font(.system(size: 14))
                                .foregroundColor(.appTextSecondary)
                        }
                        Spacer()
                        AvatarView(size: 46)
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
 
                    // Búsqueda + botón filtros
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.appTextSecondary)
                        TextField("", text: $searchText)
                            .font(.system(size: 15))
                        Spacer()
                        IconButton(
                            systemName: "line.3.horizontal.decrease",
                            size: 42,
                            iconSize: 16,
                            foregroundColor: .white,
                            backgroundColor: .appPink
                        ) { showFilter = true }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(Color.appGray)
                    .cornerRadius(12)
                    .padding(.horizontal)
 
                    // Selector de fecha
                    HStack(spacing: 8) {
                        Image(systemName: "calendar")
                            .foregroundColor(.appPink)
                        Text("14/03/2026")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.appGrayMid))
                    .padding(.horizontal)
 
                    // Título sección
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Todos tus planes en un solo lugar")
                            .font(.system(size: 18, weight: .bold))
                        Rectangle()
                            .fill(Color.appPink)
                            .frame(height: 2)
                    }
                    .padding(.horizontal)
 
                    // Lista de experiencias
                    LazyVStack(spacing: 14) {
                        ForEach(0..<4, id: \.self) { _ in
                            NavigationLink(destination: ExperienceDetailView()) {
                                ExperienceCard()
                                    .padding(.horizontal)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            .background(Color.white)
            .sheet(isPresented: $showFilter) { FilterSheetView() }
        }
    }
}
