//
//  BusinessRegisterView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct BusinessRegisterView: View {
    @State private var businessName = ""
    @State private var ownerName = ""
    @State private var businessType = ""
    @State private var description = ""
    @State private var location = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var tiktok = ""
    @State private var instagram = ""
    @State private var facebook = ""
    @State private var showTerms = false
    @Environment(\.dismiss) var dismiss
 
    private let types = ["Café","Restaurante","Taller","Tour","Galería","Otro"]
 
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                BackButton { dismiss() }
                Spacer()
                Text("Registro").font(.system(size: 16, weight: .medium))
                Spacer()
                Color.clear.frame(width: 40, height: 40)
            }
            .padding(.horizontal).padding(.vertical, 12)
 
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 14) {
                    Text("Crea una cuenta")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.top, 8)
 
                    AppTextField(placeholder: "Nombre del negocio", text: $businessName)
                    AppTextField(placeholder: "Nombre del dueño", text: $ownerName)
                    DropdownField(placeholder: "Tipo de negocio",
                                  options: types, selected: $businessType)
                    AppTextField(placeholder: "Descripción del negocio", text: $description)
                    ImagePickerField(label: "logo")
                    AppTextField(placeholder: "Ubicación", text: $location)
                    AppTextField(placeholder: "Teléfono", text: $phone, keyboardType: .phonePad)
                    PasswordField(placeholder: "Contraseña", text: $password)
                    AppTextField(placeholder: "TikTok", text: $tiktok)
                    AppTextField(placeholder: "Instagram", text: $instagram)
                    AppTextField(placeholder: "Facebook", text: $facebook)
 
                    Spacer(minLength: 32)
                }
                .padding(.horizontal)
            }
 
            VStack(spacing: 12) {
                VStack(spacing: 4) {
                    Text("Al registrarte estas de acuerdo con nuestros")
                        .font(.system(size: 13)).foregroundColor(.appTextSecondary)
                    Button { showTerms = true } label: {
                        Text("Términos y condiciones")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.appPink)
                    }
                }
                HStack { Spacer(); NextButton() }
            }
            .padding(.horizontal).padding(.bottom, 28)
        }
        .background(Color.white.ignoresSafeArea())
        .navigationBarHidden(true)
        .sheet(isPresented: $showTerms) { TermsView() }
    }
}
