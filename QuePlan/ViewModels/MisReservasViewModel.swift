import Foundation
import Combine

@MainActor
final class MisReservasViewModel: ObservableObject {
    @Published var reservas: [Reserva] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = QueplanService()

    var reservasActivas: [Reserva] {
        reservas.filter {
            ($0.estado == "pendiente" || $0.estado == "confirmada") && !esPasada($0)
        }
    }

    var reservasHistorial: [Reserva] {
        reservas.filter {
            $0.estado == "cancelada" || $0.estado == "completada" || esPasada($0)
        }
    }

    func estadoDisplay(_ reserva: Reserva) -> String {
        if esPasada(reserva) { return "Completada" }
        return reserva.estado?.capitalized ?? ""
    }

    private func esPasada(_ reserva: Reserva) -> Bool {
        guard let fecha = reserva.fechaHora else { return false }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let fechaDate = formatter.date(from: fecha) else { return false }
        return fechaDate < Date() && reserva.estado == "confirmada"
    }

    func load(idCliente: Int) async {
        isLoading = true
        errorMessage = nil

        do {
            let reservas = try await service.getReservasCliente(idCliente: idCliente)
            self.reservas = reservas
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
