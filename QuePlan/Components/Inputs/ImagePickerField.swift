//
//  ImagePickerField.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct ImagePickerField: View {
    let label: String
    var action: () -> Void = {}
 
    var body: some View {
        Button(action: action) {
            HStack {
                Text(label)
                    .font(.system(size: 15))
                    .foregroundColor(.appTextSecondary)
                Spacer()
                Image(systemName: "plus")
                    .foregroundColor(.appPink)
                    .font(.system(size: 18))
            }
            .padding(.horizontal, 16)
            .frame(height: 52)
            .background(Color.appGray)
            .cornerRadius(10)
        }
    }
}

struct DropdownField: View {
    let placeholder: String
    let options: [String]
    @Binding var selected: String
 
    var body: some View {
        Menu {
            ForEach(options, id: \.self) { opt in
                Button(opt) { selected = opt }
            }
        } label: {
            HStack {
                Text(selected.isEmpty ? placeholder : selected)
                    .font(.system(size: 15))
                    .foregroundColor(selected.isEmpty ? .appTextSecondary : .appTextPrimary)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(.appPink)
                    .font(.system(size: 13))
            }
            .padding(.horizontal, 16)
            .frame(height: 52)
            .background(Color.appGray)
            .cornerRadius(10)
        }
    }
}
 
#Preview {
    VStack(spacing: 12) {
        AppTextField(placeholder: "Nombre", text: .constant(""))
        PasswordField(placeholder: "Contraseña", text: .constant(""))
        ImagePickerField(label: "Imagen")
        DropdownField(placeholder: "Tipo de negocio",
                      options: ["Café", "Restaurante", "Taller"],
                      selected: .constant(""))
    }
    .padding()
}
