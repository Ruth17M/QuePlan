//
//  BusinessHistoryView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct BusinessHistoryView: View {
    @State private var selectedDay = 2
    @State private var showFullCal = false
    @State private var currentMonth: Date = Date()
 
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Hola, Ruth").font(.system(size: 22, weight: .bold))
                            Text("Vive lo Xico, disfruta a lo grande")
                                .font(.system(size: 13)).foregroundColor(.appTextSecondary)
                        }
                        Spacer()
                        AvatarView(size: 42)
                    }
                    .padding(.horizontal).padding(.top, 16)
 
                    VStack(spacing: 12) {
                        MonthPickerButton(currentMonth: $currentMonth).frame(maxWidth: .infinity, alignment: .leading)
                        if showFullCal {
                            MonthCalendarView(selectedDay: $selectedDay, currentMonth: $currentMonth)
                        } else {
                            WeekCalendarView(selectedDay: $selectedDay, currentMonth: $currentMonth)
                        }
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) { showFullCal.toggle() }
                        } label: {
                            Image(systemName: showFullCal ? "chevron.up" : "chevron.down")
                                .foregroundColor(.appPink).frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal)
 
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text("15").font(.system(size: 40, weight: .bold))
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 6) {
                                Text("Dom").font(.system(size: 15, weight: .semibold))
                                Text("Domingo").font(.system(size: 14)).foregroundColor(.appTextSecondary)
                            }
                            Text("5 actividades programadas")
                                .font(.system(size: 13)).foregroundColor(.appTextSecondary)
                        }
                    }
                    .padding(.horizontal)
 
                    Text("Mis actividades")
                        .font(.system(size: 18, weight: .bold)).padding(.horizontal)
 
                    LazyVStack(spacing: 12) {
                        ForEach(0..<4, id: \.self) { _ in
                            NavigationLink(destination: ActivityDetailView()) {
                                ActivityRowCard()
                            }
                            .buttonStyle(.plain).padding(.horizontal)
                        }
                    }
                }
                .padding(.bottom, 24)
            }
            .background(Color.white)
            .navigationTitle("Historial")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
 
#Preview { BusinessHomeView() }
