import Foundation

@MainActor
final class ReservaViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var success = false
    @Published var reservaCreada: Reserva?

    func reservar(idCliente: Int, idEvento: Int, cantidadPersonas: Int) async {
        isLoading = true
        errorMessage = nil
        success = false

        print("📤 Enviando reserva - cliente:\(idCliente) evento:\(idEvento) personas:\(cantidadPersonas)")

        let body = ReservaRequest(
            idCliente: idCliente,
            idEvento: idEvento,
            cantidadPersonas: cantidadPersonas
        )

        do {
            let reserva: Reserva = try await ApiClient.shared.post("/reserva/save", body: body)
            reservaCreada = reserva
            success = true
            print("✅ Reserva creada:", reserva.idReservacion ?? "nil")
        } catch {
            errorMessage = error.localizedDescription
            print("❌ Error al reservar:", error)
        }

        isLoading = false
    }
}
