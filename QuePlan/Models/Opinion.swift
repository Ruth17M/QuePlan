import Foundation

struct Opinion: Codable, Identifiable {
    let idOpinion: Int?
    let idCliente: Int?
    let idEvento: Int?
    let calificacion: Int?
    let comentario: String?
    let fecha: String?
    let nombreCliente: String?
    let imagenUrl: String?

    var id: Int? { idOpinion }
}
