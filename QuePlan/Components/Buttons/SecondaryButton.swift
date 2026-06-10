//
//  SecondaryButton.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct SecondaryButton: View {
    let title: String
    var action: () -> Void = {}
 
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.appTextPrimary)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(Color.white)
                .cornerRadius(26)
                .overlay(RoundedRectangle(cornerRadius: 26).stroke(Color.appGrayMid, lineWidth: 1.5))
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
