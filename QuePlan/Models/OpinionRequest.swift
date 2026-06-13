import Foundation

struct OpinionRequest: Codable {
    let idCliente: Int
    let idEvento: Int
    let calificacion: Int
    let comentario: String?
}
