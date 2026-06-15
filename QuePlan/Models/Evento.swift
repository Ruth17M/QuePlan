import Foundation

struct Evento: Codable, Identifiable {
    let idEvento: Int?
    let idNegocio: Int?
    let nombre: String?
    let fechaHora: String?
    let ubicacion: String?
    let precio: Double?
    let descripcion: String?
    let categoria: String?
    let cupo: Int?
    let tieneEstacionamiento: Int?
    let requiereAnticipo: Int?
    let montoAnticipo: Double?
    let autoconfirmacion: Int?
    let estatus: String?
    let nombreNegocio: String?
    let logoUrl: String?
    let promedioCalificacion: Double?
    let totalOpiniones: Int?
    let imagenes: [String]?

    var id: Int? { idEvento }

    var precioFormateado: String {
        guard let precio else { return "$$" }
        return precio == 0 ? "Gratis" : "$\(Int(precio))"
    }

    var fechaFormateada: String {
        guard let fechaHora else { return "" }
        return String(fechaHora.split(separator: " ").first ?? "")
    }

    var horaFormateada: String {
        guard let fechaHora else { return "" }
        let parts = fechaHora.split(separator: " ")
        return parts.count > 1 ? String(parts[1]) : ""
    }
}

extension Evento {
    var fechaDate: Date? {
        guard let fechaHora else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "es_MX")
        return formatter.date(from: fechaHora)
    }

    var diaMes: Int {
        Calendar.current.component(.day, from: fechaDate ?? Date())
    }
}
