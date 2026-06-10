//
//  MonthCalendarView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct MonthCalendarView: View {
    @Binding var selectedDay: Int
    var highlightedDays: Set<Int> = [2, 6, 11, 16, 18, 29]
 
    private let weekLetters = ["D","L","M","W","J","V","S"]
    private let days: [Int?] = [
        nil,nil,2,3,4,5,6,
        nil,nil,nil,11,nil,nil,nil,
        15,16,nil,18,nil,nil,nil,
        29,nil,31
    ]
 
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                ForEach(weekLetters, id: \.self) { letter in
                    Text(letter)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.appTextSecondary)
                        .frame(maxWidth: .infinity)
                }
            }
 
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                ForEach(Array(days.enumerated()), id: \.offset) { _, day in
                    if let d = day {
                        let isSelected = d == selectedDay
                        let isHighlighted = highlightedDays.contains(d)
                        Button {
                            selectedDay = d
                        } label: {
                            Text("\(d)")
                                .font(.system(size: 13, weight: isHighlighted ? .bold : .regular))
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
                    } else {
                        Color.clear.frame(height: 32)
                    }
                }
            }
 
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.appPink)
                .frame(width: 40, height: 3)
        }
    }
}
 
#Preview {
    VStack(spacing: 24) {
        MonthPickerButton()
        WeekCalendarView(selectedDay: .constant(2))
        Divider()
        MonthCalendarView(selectedDay: .constant(2))
    }
    .padding()
}
