
import Foundation

final class QueplanService {

    private func request<T: Decodable>(
        _ path: String,
        method: String = "GET",
        body: Encodable? = nil
    ) async throws -> T {
        guard let url = URL(string: "\(APIConfig.baseURL)\(path)") else {
            throw URLError(.badURL)
        }
        var req = URLRequest(url: url)
        req.httpMethod = method
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        if let body {
            req.httpBody = try JSONEncoder().encode(body)
        }
        let (data, _) = try await URLSession.shared.data(for: req)
        return try JSONDecoder().decode(T.self, from: data)
    }

    private func requestVoid(
        _ path: String,
        method: String
    ) async throws {
        guard let url = URL(string: "\(APIConfig.baseURL)\(path)") else {
            throw URLError(.badURL)
        }
        var req = URLRequest(url: url)
        req.httpMethod = method
        let (_, _) = try await URLSession.shared.data(for: req)
    }

//negocio
    func loginNegocio(usuario: String, password: String) async throws -> Negocio {
        let body = NegocioLoginRequest(usuario: usuario, passwordHash: password)
        let result: Negocio = try await request("/negocio/login", method: "POST", body: body)
        return result
    }

    func registrarNegocio(_ data: NegocioRegistroRequest) async throws -> Negocio {
        return try await request("/negocio/registro", method: "POST", body: data)
    }

    func actualizarNegocio(_ data: NegocioActualizarRequest) async throws -> Negocio {
        return try await request("/negocio/actualizar", method: "PUT", body: data)
    }

//cliente
    func loginCliente(usuario: String, password: String) async throws -> Cliente {
        let body = ClienteLoginRequest(usuario: usuario, passwordHash: password)
        return try await request("/cliente/login", method: "POST", body: body)
    }

    func registrarCliente(_ body: ClienteRegistroRequest) async throws -> Cliente {
        var request = URLRequest(url: URL(string: "\(APIConfig.baseURL)/clientes/registro")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Cliente.self, from: data)
    }

//eventos
    func getEventosNegocio(idNegocio: Int) async throws -> [Evento] {
        return try await request("/evento/getAll/\(idNegocio)")
    }

    func getEventosDisponibles(
        nombre: String? = nil,
        fechaDesde: String? = nil,
        fechaHasta: String? = nil
    ) async throws -> [Evento] {
        var params: [String] = []
        if let nombre, !nombre.isEmpty { params.append("nombre=\(nombre)") }
        if let fechaDesde { params.append("fechaDesde=\(fechaDesde)") }
        if let fechaHasta { params.append("fechaHasta=\(fechaHasta)") }
        let query = params.isEmpty ? "" : "?" + params.joined(separator: "&")
        return try await request("/evento/getDisponibles\(query)")
    }

    func getEvento(id: Int) async throws -> Evento {
        return try await request("/evento/get/\(id)")
    }

    func crearEvento(_ data: EventoSaveRequest) async throws -> Evento {
        return try await request("/evento/save", method: "POST", body: data)
    }

    func cancelarEvento(id: Int) async throws -> CancelEventoResponse {
        return try await request("/evento/delete/\(id)", method: "DELETE")
    }

//reservas
    func getReservasNegocioEvento(idEvento: Int) async throws -> [Reserva] {
        return try await request("/reserva/getAllByEvento/\(idEvento)")
    }

    func getReservasCliente(idCliente: Int) async throws -> [Reserva] {
        return try await request("/reserva/getAll/\(idCliente)")
    }

    func crearReserva(idCliente: Int, idEvento: Int, cantidadPersonas: Int) async throws -> Reserva {
        let body = ReservaRequest(idCliente: idCliente, idEvento: idEvento, cantidadPersonas: cantidadPersonas)
        return try await request("/reserva/save", method: "POST", body: body)
    }

    func confirmarReserva(id: Int) async throws {
        try await requestVoid("/reserva/confirmar/\(id)", method: "PUT")
    }

    func cancelarReserva(id: Int) async throws {
        try await requestVoid("/reserva/cancelar/\(id)", method: "PUT")
    }

//opiniones
    func getOpiniones(idEvento: Int) async throws -> [Opinion] {
        return try await request("/opinion/getByEvento/\(idEvento)")
    }

    func getOpinionesNegocio(idNegocio: Int) async throws -> [Opinion] {
        return try await request("/opinion/getByNegocio/\(idNegocio)")
    }

    func crearOpinion(_ data: OpinionRequest) async throws {
        guard let url = URL(string: "\(APIConfig.baseURL)/opinion/save") else { return }
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try JSONEncoder().encode(data)
        let (_, _) = try await URLSession.shared.data(for: req)
    }
}
