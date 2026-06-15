//
//  LoginView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var session: AppSession
    @StateObject private var vm = LoginViewModel()
    @State private var esTurista = false
    @State private var goRegister = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {

                ZStack(alignment: .bottom) {
                    Color.appPink
                    Ellipse()
                        .fill(Color.white)
                        .frame(width: 500, height: 80)
                        .offset(y: 40)

                    VStack(spacing: 14) {
                        Image(systemName: "x.circle")
                            .resizable().scaledToFit()
                            .frame(width: 72, height: 72)
                            .foregroundColor(.white)
                        Text("¡QuePlan!")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 48)
                }
                .frame(height: 260)

                //formulario
                VStack(alignment: .leading, spacing: 18) {

                    // Selector Negocio / Turista
                    HStack(spacing: 0) {
                        tabButton(title: "Negocio", activo: !esTurista) {
                            withAnimation { esTurista = false }
                        }
                        tabButton(title: "Turista", activo: esTurista) {
                            withAnimation { esTurista = true }
                        }
                    }
                    .background(Color.appGray)
                    .cornerRadius(10)

                    Text("Ingresa con tu cuenta")
                        .font(.system(size: 18, weight: .semibold))
                        .padding(.top, 4)

                    AppTextField(placeholder: "Usuario", text: $vm.usuario)
                    PasswordField(placeholder: "Contraseña", text: $vm.password)

                    Button("¿Olvidaste tu contraseña?") {}
                        .font(.system(size: 13))
                        .foregroundColor(.appTextSecondary)

                    if let error = vm.errorMessage {
                        Text(error)
                            .font(.system(size: 13))
                            .foregroundColor(.red)
                            .padding(.horizontal, 4)
                    }

                    if vm.isLoading {
                        ProgressView().frame(maxWidth: .infinity).padding(.vertical, 4)
                    } else {
                        PrimaryButton(title: "Iniciar sesión") {
                            Task {
                                if esTurista {
                                    await vm.loginCliente()
                                } else {
                                    await vm.loginNegocio()
                                }
                            }
                        }
                    }

                    HStack(spacing: 4) {
                        Text("¿No tienes una cuenta?")
                            .font(.system(size: 13))
                            .foregroundColor(.appTextSecondary)
                        Button("Regístrate") { goRegister = true }
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.appPink)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 4)
                }
                .padding(.horizontal, 28)
                .padding(.top, 32)
                .padding(.bottom, 48)
            }
        }
        .background(Color.white.ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $goRegister) { AccountTypeView() }
        .onChange(of: vm.loginExitoso) { exitoso in
            guard exitoso else { return }
            if esTurista, let cliente = vm.clienteLogueado {
                session.loginCliente(cliente)
            } else if let negocio = vm.negocioLogueado {
                session.loginNegocio(negocio)
            }
        }
    }

    @ViewBuilder
    private func tabButton(title: String, activo: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 11)
                .background(activo ? Color.appPink : Color.clear)
                .foregroundColor(activo ? .white : .appTextSecondary)
        }
        .cornerRadius(10)
    }
}
