import Foundation
import Combine

@MainActor
final class MisReservasViewModel: ObservableObject {
    @Published var reservas: [Reserva] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = QueplanService()

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
            let reservas = try await service.getReservas(idCliente: idCliente)
            self.reservas = reservas
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
