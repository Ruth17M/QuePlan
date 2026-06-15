import Foundation
import Combine

final class QueplanService {
    func getEventosDisponibles(nombre: String? = nil, fechaDesde: String? = nil, fechaHasta: String? = nil) async throws -> [Evento] {
        var endpoint = "\(APIConfig.baseURL)/evento/getDisponibles"

        var params: [String] = []
        if let nombre, !nombre.isEmpty {
            params.append("nombre=\(nombre)")
        }
        if let fechaDesde {
            params.append("fechaDesde=\(fechaDesde)")
        }
        if let fechaHasta {
            params.append("fechaHasta=\(fechaHasta)")
        }
        if !params.isEmpty {
            endpoint += "?" + params.joined(separator: "&")
        }

        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Evento].self, from: data)
    }

    func getEvento(id: Int) async throws -> Evento {
        guard let url = URL(string: "\(APIConfig.baseURL)/evento/get/\(id)") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Evento.self, from: data)
    }

    func getOpiniones(idEvento: Int) async throws -> [Opinion] {
        guard let url = URL(string: "\(APIConfig.baseURL)/opinion/getByEvento/\(idEvento)") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Opinion].self, from: data)
    }

    func crearReserva(idCliente: Int, idEvento: Int, cantidadPersonas: Int) async throws -> Reserva {
        guard let url = URL(string: "\(APIConfig.baseURL)/reserva/save") else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(
            ReservaRequest(idCliente: idCliente, idEvento: idEvento, cantidadPersonas: cantidadPersonas)
        )
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Reserva.self, from: data)
    }

    func getReservas(idCliente: Int) async throws -> [Reserva] {
        guard let url = URL(string: "\(APIConfig.baseURL)/reserva/getAll/\(idCliente)") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Reserva].self, from: data)
    }
}
