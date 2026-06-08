//
//  TouristEditProfile.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//
import SwiftUI

struct TouristEditProfileView: View {
    @State private var name = "Juan Pedre"
    @State private var phone = "477123445"
    @State private var password = ""
    @State private var showTerms = false
    @Environment(\.dismiss) var dismiss
 
    var body: some View {
        VStack(spacing: 0) {
            // Header rosa con ola y avatar
            ZStack(alignment: .bottom) {
                PinkWaveHeader(height: 200)
                    .overlay(
                        HStack {
                            Button { dismiss() } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Text("Editar perfil")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                            Spacer()
                            Color.clear.frame(width: 24)
                        }
                        .padding(.horizontal)
                        .padding(.top, 12),
                        alignment: .top
                    )
                EditableAvatarView(size: 100)
                    .offset(y: 50)
            }
            .frame(height: 200)
            .padding(.bottom, 50)
 
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
 
                    // Nombre completo (solo lectura visual)
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Nombre completo")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.appTextSecondary)
                        Text(name)
                            .font(.system(size: 15))
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 48)
                            .background(Color.appGray)
                            .cornerRadius(10)
                    }
 
                    // Teléfono
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Teléfono")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.appTextSecondary)
                        AppTextField(placeholder: "Teléfono", text: $phone, keyboardType: .phonePad)
                    }
 
                    // Contraseña
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Contraseña")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.appTextSecondary)
                        PasswordField(placeholder: "••••••••••", text: $password)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
 
            // Acciones
            VStack(spacing: 12) {
                Button { showTerms = true } label: {
                    Text("Términos y condiciones")
                        .font(.system(size: 14))
                        .foregroundColor(.appPink)
                }
                PrimaryButton(title: "Guardar cambios") { dismiss() }
                Button("Cancelar") { dismiss() }
                    .font(.system(size: 15))
                    .foregroundColor(.appTextSecondary)
            }
            .padding(.horizontal)
            .padding(.bottom, 28)
        }
        .background(Color.white.ignoresSafeArea())
        .navigationBarHidden(true)
        .sheet(isPresented: $showTerms) { TermsView() }
    }
}
 
#Preview {
    TouristRegisterView()
}
