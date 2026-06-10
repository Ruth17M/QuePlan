//
//  BackButton.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//


import SwiftUI

struct BackButton: View {
    var action: () -> Void = {}
 
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.appTextPrimary)
                .frame(width: 40, height: 40)
                .background(Color.appGray)
                .clipShape(Circle())
        }
    }
}

struct NextButton: View {
    var action: () -> Void = {}
 
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.right")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.appPink)
                .frame(width: 52, height: 52)
                .background(Color.white)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.appGrayMid, lineWidth: 1.5))
        }
    }
}
 
#Preview {
    VStack(spacing: 16) {
        PrimaryButton(title: "Iniciar sesión")
        SecondaryButton(title: "Registrarse")
        HStack { BackButton(); NextButton() }
    }
    .padding()
}
