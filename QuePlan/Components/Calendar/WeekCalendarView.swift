//
//  WeekCalendarView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct WeekCalendarView: View {
    @Binding var selectedDay: Int
    var highlightedDays: Set<Int> = [2, 6]
 
    private let weekLetters = ["D","L","M","W","J","V","S"]
    private let weekNumbers = [1,2,3,4,5,6,7]
 
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                ForEach(Array(weekLetters.enumerated()), id: \.offset) { i, letter in
                    Text(letter)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.appTextSecondary)
                        .frame(maxWidth: .infinity)
                }
            }
            HStack {
                ForEach(Array(weekNumbers.enumerated()), id: \.offset) { i, num in
                    let isSelected = num == selectedDay
                    let isHighlighted = highlightedDays.contains(num)
                    Button {
                        selectedDay = num
                    } label: {
                        Text("\(num)")
                            .font(.system(size: 14, weight: isSelected || isHighlighted ? .bold : .regular))
                            .frame(width: 32, height: 32)
                            .background(
                                Circle().fill(
                                    isSelected ? Color.appPink :
                                    isHighlighted ? Color.appPink : Color.clear
                                )
                            )
                            .foregroundColor(
                                isSelected || isHighlighted ? .white : .appTextPrimary
                            )
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.appPink)
                .frame(width: 40, height: 3)
        }
    }
}
 
