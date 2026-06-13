import SwiftUI

struct TouristMyExpView: View {
    @StateObject private var viewModel = MisReservasViewModel()
    @State private var selectedDay = 2
    @State private var showFullCal = false

    private let clienteId = 1

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Hola, Ruth")
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
                        MonthPickerButton()
                            .frame(maxWidth: .infinity, alignment: .leading)

                        if showFullCal {
                            MonthCalendarView(selectedDay: $selectedDay)
                        } else {
                            WeekCalendarView(selectedDay: $selectedDay)
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
                        Text("15")
                            .font(.system(size: 42, weight: .bold))
                        VStack(alignment: .leading, spacing: 2) {
                            HStack(spacing: 6) {
                                Text("Dom")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("Hoy")
                                    .font(.system(size: 15))
                                    .foregroundColor(.appTextSecondary)
                            }
                            Text("\(viewModel.reservasActivas.count) \(viewModel.reservasActivas.count == 1 ? "tour programado" : "tours programados")")
                                .font(.system(size: 13))
                                .foregroundColor(.appTextSecondary)
                        }
                    }
                    .padding(.horizontal)

                    Text("Mis actividades")
                        .font(.system(size: 18, weight: .bold))
                        .padding(.horizontal)

                    // Estado de carga
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                    }

                    // Scroll horizontal de tarjetas
                    if viewModel.reservasActivas.isEmpty && !viewModel.isLoading {
                        Text("No tienes reservas activas")
                            .font(.system(size: 14))
                            .foregroundColor(.appTextSecondary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                ForEach(viewModel.reservasActivas) { reserva in
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
            .task { await viewModel.load(idCliente: clienteId) }
        }
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
