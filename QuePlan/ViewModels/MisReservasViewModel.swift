import Foundation

@MainActor
final class MisReservasViewModel: ObservableObject {
    @Published var reservas: [Reserva] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    var reservasActivas: [Reserva] {
        reservas.filter { $0.estado == "pendiente" || $0.estado == "confirmada" }
    }

    var reservasHistorial: [Reserva] {
        reservas.filter { $0.estado == "cancelada" || $0.estado == "completada" }
    }

    func load(idCliente: Int) async {
        isLoading = true
        errorMessage = nil

        do {
            let reservas: [Reserva] = try await ApiClient.shared.get("/reserva/getAll/\(idCliente)")
            self.reservas = reservas
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
