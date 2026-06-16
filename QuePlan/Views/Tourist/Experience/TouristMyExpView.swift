import SwiftUI

struct TouristMyExpView: View {
    @EnvironmentObject var session: AppSession
    @StateObject private var viewModel = MisReservasViewModel()
    @State private var selectedDay = Calendar.current.component(.day, from: Date())
    @State private var currentMonth: Date = Date()
    @State private var showFullCal = false

    private var reservasDelDia: [Reserva] {
        viewModel.reservasActivas.filter { reserva in
            guard let fecha = reserva.fechaHora else { return false }
            let f = DateFormatter()
            f.dateFormat = "yyyy-MM-dd HH:mm:ss"
            guard let date = f.date(from: fecha) else { return false }
            return Calendar.current.isDate(date, equalTo: fechaDelMes(selectedDay), toGranularity: .day)
        }
    }

    private func fechaDelMes(_ day: Int) -> Date {
        var comps = Calendar.current.dateComponents([.year, .month], from: currentMonth)
        comps.day = day
        return Calendar.current.date(from: comps) ?? Date()
    }

    private func diasConReservas(en mes: Date) -> Set<Int> {
        Set(viewModel.reservasActivas.compactMap { reserva in
            guard let fecha = reserva.fechaHora else { return nil }
            let f = DateFormatter()
            f.dateFormat = "yyyy-MM-dd HH:mm:ss"
            guard let date = f.date(from: fecha) else { return nil }
            guard Calendar.current.isDate(date, equalTo: mes, toGranularity: .month) else { return nil }
            return Calendar.current.component(.day, from: date)
        })
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Hola, \(session.cliente?.nombre ?? "Turista")")
                                .font(.system(size: 22, weight: .bold))
                            Text("Descubre, reserva y vive experiencias.")
                                .font(.system(size: 13))
                                .foregroundColor(.appTextSecondary)
                        }
                        Spacer()
                        AvatarView(size: 42)
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)

                    // Calendario
                    VStack(spacing: 12) {
                        HStack {
                            Button {
                                withAnimation { currentMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth }
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.appPink)
                            }
                            Spacer()
                            MonthPickerButton(monthName: nombreMes(currentMonth))
                            Spacer()
                            Button {
                                withAnimation { currentMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth }
                            } label: {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.appPink)
                            }
                        }

                        if showFullCal {
                            MonthCalendarView(selectedDay: $selectedDay, highlightedDays: diasConReservas(en: currentMonth), month: currentMonth)
                        } else {
                            WeekCalendarView(selectedDay: $selectedDay, highlightedDays: diasConReservas(en: currentMonth))
                        }

                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showFullCal.toggle()
                            }
                        } label: {
                            Image(systemName: showFullCal ? "chevron.up" : "chevron.down")
                                .foregroundColor(.appPink)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal)

                    // Día seleccionado
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text("\(selectedDay)")
                            .font(.system(size: 42, weight: .bold))
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 6) {
                                Text(nombreDia(fechaDelMes(selectedDay)))
                                    .font(.system(size: 16, weight: .semibold))
                                if Calendar.current.isDateInToday(fechaDelMes(selectedDay)) {
                                    Text("Hoy")
                                        .font(.system(size: 15))
                                        .foregroundColor(.appTextSecondary)
                                }
                            }
                            Text("\(reservasDelDia.count) \(reservasDelDia.count == 1 ? "tour programado" : "tours programados")")
                                .font(.system(size: 13))
                                .foregroundColor(.appTextSecondary)
                        }
                    }
                    .padding(.horizontal)

                    Text("Mis actividades")
                        .font(.system(size: 18, weight: .bold))
                        .padding(.horizontal)

                    // Scroll horizontal de tarjetas
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                    } else if reservasDelDia.isEmpty {
                        Text(viewModel.reservasActivas.isEmpty
                             ? "No tienes reservas activas"
                             : "Sin actividades para este día")
                            .font(.system(size: 14))
                            .foregroundColor(.appTextSecondary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                ForEach(reservasDelDia) { reserva in
                                    MyExpCard(reserva: reserva)
                                        .frame(width: 220)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.bottom, 24)
            }
            .background(Color.white)
            .task { await viewModel.load(idCliente: session.cliente?.idCliente ?? 0) }
        }
    }

    private func nombreMes(_ date: Date) -> String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "es_MX")
        f.dateFormat = "MMMM yyyy"
        return f.string(from: date).capitalized
    }

    private func nombreDia(_ date: Date) -> String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "es_MX")
        return f.shortWeekdaySymbols[Calendar.current.component(.weekday, from: date) - 1].capitalized
    }
}

private struct MyExpCard: View {
    let reserva: Reserva

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.2))
                .frame(height: 200)

            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.5)],
                        startPoint: .top, endPoint: .bottom
                    )
                )
                .frame(height: 200)

            IconButton(systemName: "heart", iconSize: 16, foregroundColor: .white)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(6)

            VStack(alignment: .leading, spacing: 4) {
                Text(reserva.nombreEvento ?? "Actividad")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .lineLimit(2)
                HStack(spacing: 3) {
                    Image(systemName: "calendar")
                        .font(.system(size: 10))
                    Text(reserva.fechaFormateada)
                        .font(.system(size: 11))
                }
                .foregroundColor(.white)

                HStack(spacing: 4) {
                    Text(reserva.estado?.capitalized ?? "")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            reserva.estado == "confirmada" ? Color.green.opacity(0.7) :
                            reserva.estado == "pendiente" ? Color.orange.opacity(0.7) :
                            Color.gray.opacity(0.5)
                        )
                        .cornerRadius(8)

                    Spacer()
                }

                HStack {
                    Text("\(reserva.cantidadPersonas ?? 1) \(reserva.cantidadPersonas == 1 ? "persona" : "personas")")
                        .font(.system(size: 11))
                        .foregroundColor(.white.opacity(0.8))
                    Spacer()
                    Circle()
                        .fill(Color.white)
                        .frame(width: 28, height: 28)
                        .overlay(
                            Image(systemName: "chevron.right")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.appTextPrimary)
                        )
                }
            }
            .padding(12)
        }
    }
}
