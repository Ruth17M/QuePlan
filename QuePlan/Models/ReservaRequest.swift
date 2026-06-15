import Foundation
import Combine

struct ReservaRequest: Codable {
    let idCliente: Int
    let idEvento: Int
    let cantidadPersonas: Int
}
