import Foundation

@MainActor
final class ReservaViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var success = false
    @Published var reservaCreada: Reserva?

    private let service = QueplanService()

    func reservar(idCliente: Int, idEvento: Int, cantidadPersonas: Int) async {
        isLoading = true
        errorMessage = nil
        success = false

        do {
            let reserva = try await service.crearReserva(
                idCliente: idCliente,
                idEvento: idEvento,
                cantidadPersonas: cantidadPersonas
            )
            reservaCreada = reserva
            success = true
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
