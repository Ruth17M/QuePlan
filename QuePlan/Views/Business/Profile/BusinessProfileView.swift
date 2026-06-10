//
//  BusinessProfileView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct BusinessProfileView: View {
    @State private var showEdit = false
    @State private var showLogout = false
 
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
 
                    // Header rosa con nombre "Mi perfil"
                    ZStack(alignment: .bottom) {
                        PinkWaveHeader(height: 200)
                        Text("Mi perfil")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.bottom, 44)
                    }
                    .overlay(
                        EditableAvatarView(size: 100)
                            .offset(y: 50),
                        alignment: .bottom
                    )
 
                    // Contenido
                    VStack(alignment: .leading, spacing: 20) {
                        Spacer().frame(height: 44)
 
                        // Nombre del negocio (solo lectura)
                        ProfileReadField(label: "Nombre del negocio", value: "Juan Pedre")
                        ProfileReadField(label: "Teléfono", value: "477123456")
 
                        // Logo
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Logo")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.appTextSecondary)
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.appGray).frame(height: 160)
                                Image(systemName: "photo")
                                    .font(.system(size: 36))
                                    .foregroundColor(.appTextSecondary)
                            }
                        }
 
                        // Editar vista previa
                        Button {} label: {
                            HStack {
                                Text("Editar vista previa de negocio")
                                    .font(.system(size: 15)).foregroundColor(.appTextSecondary)
                                Spacer()
                                Image(systemName: "pencil.circle.fill")
                                    .font(.system(size: 22)).foregroundColor(.appPink)
                            }
                            .padding(14)
                            .background(Color.appGray).cornerRadius(12)
                        }
 
                        // Links
                        VStack(spacing: 6) {
                            Text("Conoce más sobre")
                                .font(.system(size: 14)).foregroundColor(.appTextSecondary)
                            Button("MI EXPERIENCIA") {}
                                .font(.system(size: 14, weight: .bold)).foregroundColor(.appPink)
                        }
                        .frame(maxWidth: .infinity)
 
                        Button { showLogout = true } label: {
                            Text("¿Desea cerrar sesión?")
                                .font(.system(size: 15)).foregroundColor(.appPink)
                        }
                        .frame(maxWidth: .infinity)
 
                        HStack(spacing: 20) {
                            Button("Términos y condiciones") {}
                                .font(.system(size: 13)).foregroundColor(.appTextSecondary)
                            Button("Ayuda") {}
                                .font(.system(size: 13)).foregroundColor(.appTextSecondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal).padding(.bottom, 40)
                }
            }
            .ignoresSafeArea(edges: .top)
            .background(Color.white)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { showEdit = true } label: {
                        Image(systemName: "pencil")
                            .foregroundColor(.appPink)
                    }
                }
            }
            .confirmationDialog("¿Cerrar sesión?", isPresented: $showLogout, titleVisibility: .visible) {
                Button("Cerrar sesión", role: .destructive) {}
                Button("Cancelar", role: .cancel) {}
            }
            .sheet(isPresented: $showEdit) { EditBusinessProfileView() }
        }
    }
}
