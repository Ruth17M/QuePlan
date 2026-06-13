import Foundation

struct ReservaRequest: Codable {
    let idCliente: Int
    let idEvento: Int
    let cantidadPersonas: Int
}
