//
//  MonthPickerButton.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct MonthPickerButton: View {
    var monthName: String = "Marzo"
 
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "calendar")
                .foregroundColor(.appPink)
                .font(.system(size: 16))
            Text(monthName)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.appTextPrimary)
            Image(systemName: "chevron.down")
                .foregroundColor(.appTextPrimary)
                .font(.system(size: 12, weight: .medium))
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 9)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.appPink, lineWidth: 1.5))
    }
}
 
