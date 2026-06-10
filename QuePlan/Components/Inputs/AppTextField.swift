//
//  AppTextField.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct AppTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
 
    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(keyboardType)
            .font(.system(size: 15))
            .foregroundColor(.appTextPrimary)
            .padding(.horizontal, 16)
            .frame(height: 52)
            .background(Color.appGray)
            .cornerRadius(10)
    }
}

#Preview {
    
}