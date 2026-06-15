import SwiftUI

struct TouristHistoryView: View {
    @EnvironmentObject var session: AppSession
    @StateObject private var viewModel = MisReservasViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.reservasHistorial.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.system(size: 48))
                            .foregroundColor(.appGrayMid)
                        Text("No tienes historial")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.appTextSecondary)
                        Text("Tus reservas pasadas aparecerán aquí")
                            .font(.system(size: 13))
                            .foregroundColor(.appTextSecondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(viewModel.reservasHistorial) { reserva in
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text(reserva.nombreEvento ?? "Actividad")
                                    .font(.system(size: 15, weight: .semibold))
                                Spacer()
                                Text(viewModel.estadoDisplay(reserva))
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(
                                        viewModel.estadoDisplay(reserva) == "Cancelada" ? .red :
                                        viewModel.estadoDisplay(reserva) == "Completada" ? .green :
                                        .appTextSecondary
                                    )
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
                                    .background(
                                        viewModel.estadoDisplay(reserva) == "Cancelada" ? Color.red.opacity(0.1) :
                                        viewModel.estadoDisplay(reserva) == "Completada" ? Color.green.opacity(0.1) :
                                        Color.gray.opacity(0.1)
                                    )
                                    .cornerRadius(6)
                            }
                            HStack(spacing: 12) {
                                Label(reserva.fechaFormateada, systemImage: "calendar")
                                Label("\(reserva.cantidadPersonas ?? 1) pers", systemImage: "person")
                            }
                            .font(.system(size: 12))
                            .foregroundColor(.appTextSecondary)
                        }
                        .padding(.vertical, 4)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Historial")
        }
        .task { await viewModel.load(idCliente: session.cliente?.idCliente ?? 0) }
    }
}
