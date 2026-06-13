import Foundation

struct Reserva: Codable, Identifiable {
    let idReservacion: Int?
    let idCliente: Int?
    let idEvento: Int?
    let cantidadPersonas: Int?
    let estado: String?
    let fechaReservacion: String?
    let nombreCliente: String?
    let telefonoCliente: String?
    let nombreEvento: String?
    let fechaHora: String?

    var id: Int? { idReservacion }

    var fechaFormateada: String {
        guard let fechaHora else { return "" }
        return String(fechaHora.split(separator: " ").first ?? "")
    }
}
