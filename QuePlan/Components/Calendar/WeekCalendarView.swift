//
//  WeekCalendarView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct WeekCalendarView: View {
    @Binding var selectedDay: Int
    var highlightedDays: Set<Int> = []

    private let weekLetters = ["D","L","M","W","J","V","S"]

    private var weekNumbers: [Int] {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - 1), to: today)!
        return (0..<7).compactMap {
            calendar.component(.day, from: calendar.date(byAdding: .day, value: $0, to: startOfWeek)!)
        }
    }
 
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
                    let isHighlighted = highlightedDays.contains(num)
                    let isSelected = num == selectedDay && isHighlighted
                    Button {
                        if highlightedDays.contains(num) { selectedDay = num }
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
 
