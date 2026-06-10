//
//  TouristTabView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct TouristTabView: View {
    var body: some View {
        TabView {
            TouristHomeView()
                .tabItem { Label("Inicio", systemImage: "house") }
 
            TouristMyExpView()
                .tabItem { Label("Mi experiencia", systemImage: "heart") }
                .badge(1)
 
            TouristHistoryView()
                .tabItem { Label("Historial", systemImage: "list.bullet.rectangle") }
 
            TouristProfileView()
                .tabItem { Label("Perfil", systemImage: "person") }
        }
        .tint(.appPink)
    }
}
