//
//  ProfileReadField.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct ProfileReadField: View {
    let label: String
    let value: String
 
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.appTextSecondary)
            Text(value)
                .font(.system(size: 15))
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 48)
                .background(Color.appGray)
                .cornerRadius(10)
        }
    }
}
