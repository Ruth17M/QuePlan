//
//  EditBusinessProfileView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct EditBusinessProfileView: View {
    @State private var phone = "477123445"
    @Environment(\.dismiss) var dismiss
 
    var body: some View {
        VStack(spacing: 0) {
            // Header rosa
            ZStack(alignment: .bottom) {
                PinkWaveHeader(height: 200)
                    .overlay(
                        HStack {
                            Button { dismiss() } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 18)).foregroundColor(.white)
                            }
                            Spacer()
                            Text("Editar perfil")
                                .font(.system(size: 20, weight: .semibold)).foregroundColor(.white)
                            Spacer()
                            Color.clear.frame(width: 24)
                        }
                        .padding(.horizontal).padding(.top, 12),
                        alignment: .top
                    )
                EditableAvatarView(size: 100)
                    .offset(y: 50)
            }
            .frame(height: 200).padding(.bottom, 50)
 
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
 
                    // Nombre del negocio (solo lectura)
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Nombre del negocio")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.appTextSecondary)
                        Text("Juan Pedre")
                            .font(.system(size: 15))
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 48)
                            .background(Color.appGray).cornerRadius(10)
                    }
 
                    // Teléfono (editable)
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Teléfono")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.appTextSecondary)
                        AppTextField(placeholder: "Teléfono", text: $phone,
                                     keyboardType: .phonePad)
                    }
 
                    // Logo con "Cambiar imagen"
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Logo")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.appTextSecondary)
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.appGray).frame(height: 160)
                            VStack(spacing: 8) {
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 26))
                                    .foregroundColor(.appTextSecondary)
                                Text("Cambiar imagen")
                                    .font(.system(size: 14))
                                    .foregroundColor(.appTextSecondary)
                            }
                        }
                    }
 
                    PrimaryButton(title: "Guardar cambios") { dismiss() }
                        .padding(.top, 8)
                }
                .padding(.horizontal).padding(.bottom, 40)
            }
        }
        .background(Color.white.ignoresSafeArea())
        .navigationBarHidden(true)
    }
}
 
#Preview { BusinessProfileView() }
 
