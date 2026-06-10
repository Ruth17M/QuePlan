//
//  PasswordField.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct PasswordField: View {
    let placeholder: String
    @Binding var text: String
    @State private var isVisible = false
 
    var body: some View {
        HStack {
            if isVisible {
                TextField(placeholder, text: $text)
                    .font(.system(size: 15))
            } else {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 15))
            }
            Button {
                isVisible.toggle()
            } label: {
                Image(systemName: isVisible ? "eye" : "eye.slash")
                    .foregroundColor(.appPink)
                    .font(.system(size: 18))
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
        .background(Color.appGray)
        .cornerRadius(10)
    }
}
 
