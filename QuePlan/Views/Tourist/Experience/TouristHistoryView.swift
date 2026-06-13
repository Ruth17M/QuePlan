import SwiftUI

struct TouristHistoryView: View {
    @StateObject private var viewModel = MisReservasViewModel()

    private let clienteId = 1

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
                                Text(reserva.estado?.capitalized ?? "")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(
                                        reserva.estado == "cancelada" ? .red :
                                        reserva.estado == "completada" ? .green :
                                        .appTextSecondary
                                    )
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
                                    .background(
                                        reserva.estado == "cancelada" ? Color.red.opacity(0.1) :
                                        reserva.estado == "completada" ? Color.green.opacity(0.1) :
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
        .task { await viewModel.load(idCliente: clienteId) }
    }
}
