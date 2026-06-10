//
//  BusinessTabView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI


struct BusinessTabView: View {
    var body: some View {
        TabView {
            BusinessHomeView()
                .tabItem { Label("Inicio", systemImage: "house") }
 
            BusinessHomeView()
                .tabItem { Label("Mi experiencia", systemImage: "heart") }
                .badge(1)
 
            BusinessHistoryView()
                .tabItem { Label("Historial", systemImage: "list.bullet.rectangle") }
 
            BusinessProfileView()
                .tabItem { Label("Perfil", systemImage: "person") }
        }
        .tint(.appPink)
    }
}
 
#Preview("Turista") { TouristTabView() }
#Preview("Negocio") { BusinessTabView() }
