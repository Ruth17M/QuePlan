//
//  LoginView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var goRegister = false
    @Environment(\.dismiss) var dismiss
 
    var body: some View {
        VStack(spacing: 0) {
            PinkWaveHeader(
                height: 280,
                content: AnyView(
                    VStack(spacing: 14) {
                        Image(systemName: "x.circle")
                            .resizable().scaledToFit()
                            .frame(width: 76, height: 76)
                            .foregroundColor(.white)
                        Text("¡QuePlan!")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 28)
                )
            )
 
            Spacer()
 
            VStack(alignment: .leading, spacing: 16) {
                Text("Ingresa con tu cuenta")
                    .font(.system(size: 18, weight: .semibold))
 
                AppTextField(placeholder: "Email", text: $email, keyboardType: .emailAddress)
                PasswordField(placeholder: "Contraseña", text: $password)
 
                Button("¿Olvidaste tu contraseña?") {}
                    .font(.system(size: 13))
                    .foregroundColor(.appTextSecondary)
 
                PrimaryButton(title: "Iniciar sesión")
 
                VStack(spacing: 10) {
                    Text("Ingresa con")
                        .font(.system(size: 13))
                        .foregroundColor(.appTextSecondary)
                        .frame(maxWidth: .infinity)
 
                    Button {} label: {
                        ZStack {
                            Circle().fill(Color.appGray).frame(width: 48, height: 48)
                            Text("G")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.red)
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
                }
            }
            .padding(.horizontal, 28)
 
            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $goRegister) { AccountTypeView() }
    }
}
