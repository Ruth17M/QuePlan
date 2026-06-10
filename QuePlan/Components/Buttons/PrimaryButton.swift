//
//  PrimaryButton.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//
import SwiftUI

struct PrimaryButton: View {
    let title: String
    var action: () -> Void = {}
 
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(Color.appPink)
                .cornerRadius(26)
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
