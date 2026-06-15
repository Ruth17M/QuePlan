//
//  TouristRegisterView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct TouristRegisterView: View {
    @EnvironmentObject var session: AppSession
    @StateObject private var vm = TouristRegisterViewModel()
    @State private var usuario = ""  
    @State private var name = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var showTerms = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                BackButton { dismiss() }
                Spacer()
                Text("Registro")
                    .font(.system(size: 16, weight: .medium))
                Spacer()
                Color.clear.frame(width: 40, height: 40)
            }
            .padding(.horizontal)
            .padding(.vertical, 12)

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Crea una cuenta")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.top, 8)

                    AppTextField(placeholder: "Usuario", text: $usuario)
                    AppTextField(placeholder: "Nombre", text: $name)
                    AppTextField(placeholder: "Teléfono", text: $phone, keyboardType: .phonePad)
                    ImagePickerField(label: "Imagen")
                    PasswordField(placeholder: "Contraseña", text: $password)

                    if let error = vm.errorMessage {
                        Text(error)
                            .font(.system(size: 13))
                            .foregroundColor(.red)
                    }

                    Spacer(minLength: 40)
                }
                .padding(.horizontal)
            }

            VStack(spacing: 12) {
                VStack(spacing: 4) {
                    Text("Al registrarte estas de acuerdo con nuestros")
                        .font(.system(size: 13))
                        .foregroundColor(.appTextSecondary)
                    Button { showTerms = true } label: {
                        Text("Términos y condiciones")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.appPink)
                    }
                }

                if vm.isLoading {
                    ProgressView().frame(maxWidth: .infinity)
                } else {
                    HStack {
                        Spacer()
                        NextButton {
                            Task {
                                await vm.registrar(
                                    usuario: usuario,
                                    nombre: name,
                                    telefono: phone,
                                    password: password
                                )
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 28)
        }
        .background(Color.white.ignoresSafeArea())
        .navigationBarHidden(true)
        .sheet(isPresented: $showTerms) { TermsView() }
        .onChange(of: vm.registroExitoso) { exitoso in
            guard exitoso else { return }
            if let cliente = vm.clienteRegistrado {
                session.loginCliente(cliente)
            }
        }
    }
}
