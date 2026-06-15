//
//  BusinessHomeView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.

import SwiftUI

struct BusinessHomeView: View {
    @StateObject private var vm = BusinessHomeViewModel()

    @State private var selectedDay: Int = Calendar.current.component(.day, from: Date())
    @State private var showFullCal = false

    // MARK: - Fecha de hoy formateada
    private var hoyDia: String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "es_MX")
        f.dateFormat = "EEE"
        return f.string(from: Date()).capitalized
    }
    private var hoyNumero: Int {
        Calendar.current.component(.day, from: Date())
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    // MARK: Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Hola, \(vm.nombreSaludo)")
                                .font(.system(size: 22, weight: .bold))
                            Text("Vive lo Xico, disfruta a lo grande")
                                .font(.system(size: 13))
                                .foregroundColor(.appTextSecondary)
                        }
                        Spacer()
                        // Muestra logo del negocio si existe, si no el avatar genérico
                        if let negocio = vm.negocio,
                           let logoStr = negocio.logoUrl,
                           let url = URL(string: logoStr) {
                            AsyncImage(url: url) { image in
                                image.resizable().scaledToFill()
                            } placeholder: {
                                AvatarView(size: 42)
                            }
                            .frame(width: 42, height: 42)
                            .clipShape(Circle())
                        } else {
                            AvatarView(size: 42)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)

                    // MARK: Calendario
                    VStack(spacing: 12) {
                        MonthPickerButton(currentMonth: $vm.currentMonth)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        if showFullCal {
                            MonthCalendarView(
                                selectedDay: $selectedDay,
                                currentMonth: $vm.currentMonth,
                                highlightedDays: vm.diasConEventos
                            )
                        } else {
                            WeekCalendarView(
                                selectedDay: $selectedDay,
                                currentMonth: $vm.currentMonth,
                                highlightedDays: vm.diasConEventos
                            )
                        }

                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) { showFullCal.toggle() }
                        } label: {
                            Image(systemName: showFullCal ? "chevron.up" : "chevron.down")
                                .foregroundColor(.appPink)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal)
                    .onChange(of: selectedDay) { newDay in
                        vm.diaSeleccionado = newDay
                    }
                    .onChange(of: vm.currentMonth) { _ in
                        vm.diaSeleccionado = selectedDay
                    }

                    // MARK: Resumen del día
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text("\(selectedDay)")
                            .font(.system(size: 40, weight: .bold))
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 6) {
                                Text(hoyDia)
                                    .font(.system(size: 15, weight: .semibold))
                                if selectedDay == hoyNumero {
                                    Text("Hoy")
                                        .font(.system(size: 14))
                                        .foregroundColor(.appTextSecondary)
                                }
                            }
                            let count = vm.eventosDelDia.count
                            Text(count == 0
                                 ? "Sin actividades programadas"
                                 : "\(count) actividad\(count == 1 ? "" : "es") programada\(count == 1 ? "" : "s")")
                                .font(.system(size: 13))
                                .foregroundColor(.appTextSecondary)
                        }
                    }
                    .padding(.horizontal)

                    // MARK: Lista de eventos
                    Text("Mis actividades")
                        .font(.system(size: 18, weight: .bold))
                        .padding(.horizontal)

                    if vm.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding(.top, 20)
                    } else if vm.eventosDelDia.isEmpty {
                        VStack(spacing: 8) {
                            Image(systemName: "calendar.badge.exclamationmark")
                                .font(.system(size: 36))
                                .foregroundColor(.appTextSecondary)
                            Text("No hay actividades para este día")
                                .font(.system(size: 14))
                                .foregroundColor(.appTextSecondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 20)
                    } else {
                        LazyVStack(spacing: 12) {
                            ForEach(vm.eventosDelDia) { evento in
                                NavigationLink(destination: ActivityDetailView()) {
                                    ActivityRowCard()
                                }
                                .buttonStyle(.plain)
                                .padding(.horizontal)
                            }
                        }
                    }

                    if let error = vm.errorMessage {
                        Text(error)
                            .font(.system(size: 13))
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }
                }
                .padding(.bottom, 24)
            }
            .background(Color.white)
            .refreshable {
                await vm.fetchEventos()
            }
        }
    }
}
