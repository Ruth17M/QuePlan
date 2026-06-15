//
//  Welcomeview.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct WelcomeView: View {
    @State private var goLogin = false
    @State private var goRegister = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                PinkWaveHeader(
                    height: 340,
                    content: AnyView(
                        VStack(spacing: 16) {
                            Image(systemName: "x.circle")
                                .resizable().scaledToFit()
                                .frame(width: 90, height: 90)
                                .foregroundColor(.white)
                            Text("¡QuePlan!")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, 32)
                    )
                )

                Spacer()

                VStack(spacing: 12) {
                    Text("Bienvenido")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.appPink)
                    Text("Vive lo Xico, disfruta a lo grande")
                        .font(.system(size: 15))
                        .foregroundColor(.appTextSecondary)
                        .padding(.bottom, 8)

                    PrimaryButton(title: "Iniciar sesión") { goLogin = true }
                    SecondaryButton(title: "Registrarse") { goRegister = true }
                }
                .padding(.horizontal, 32)

                Spacer()
            }
            .background(Color.white.ignoresSafeArea())
            .navigationDestination(isPresented: $goLogin) { LoginView() }
            .navigationDestination(isPresented: $goRegister) { AccountTypeView() }
        }
    }
}
