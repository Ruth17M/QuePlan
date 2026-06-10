//
//  TouristProfileView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct TouristProfileView: View {
    @State private var showEdit = false
 
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                AvatarView(size: 80)
                Text("Ruth")
                    .font(.system(size: 20, weight: .bold))
                Button("Editar perfil") { showEdit = true }
                    .font(.system(size: 15))
                    .foregroundColor(.appPink)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Perfil")
            .sheet(isPresented: $showEdit) { TouristEditProfileView() }
        }
    }
}
 
