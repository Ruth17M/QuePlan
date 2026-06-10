//
//  AccountTypeView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct AccountTypeView: View {
    @State private var goBusiness = false
    @State private var goTourist = false
    @Environment(\.dismiss) var dismiss
 
    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()
 
            VStack(spacing: 0) {
                HStack {
                    BackButton { dismiss() }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 12)
 

                VStack(spacing: 16) {
                    Image(systemName: "x.circle")
                        .resizable().scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.appPink)
 
                    Text("Bienvenido")
                        .font(.system(size: 26, weight: .bold))
 
                    Text("¿Qué tipo de cuenta deseas registrar?")
                        .font(.system(size: 16))
                        .foregroundColor(.appTextSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                .padding(.top, 16)
 
                Spacer()
 
                ZStack(alignment: .top) {
                    Color.appPink
                    Ellipse()
                        .fill(Color.white)
                        .frame(width: 700, height: 80)
                        .offset(y: -40)
 
                    HStack(spacing: 60) {
                        AccountTypeOption(icon: "storefront", label: "Negocio") {
                            goBusiness = true
                        }
                        AccountTypeOption(icon: "person", label: "Turista") {
                            goTourist = true
                        }
                    }
                    .padding(.top, 60)
                }
                .frame(height: 220)
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $goBusiness) { BusinessRegisterView() }
        .navigationDestination(isPresented: $goTourist) { TouristRegisterView() }
    }
}
 

private struct AccountTypeOption: View {
    let icon: String
    let label: String
    let action: () -> Void
 
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 36))
                    .foregroundColor(.white)
                Text(label)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
            }
        }
    }
}
 
#Preview { SplashView() }
