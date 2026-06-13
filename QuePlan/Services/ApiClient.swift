import Foundation

enum ApiError: LocalizedError {
    case serverError(String)
    case decodingError(Error)
    case networkError(Error)
    case invalidURL

    var errorDescription: String? {
        switch self {
        case .serverError(let msg): return msg
        case .decodingError(let e): return "Error de datos: \(e.localizedDescription)"
        case .networkError(let e): return "Error de red: \(e.localizedDescription)"
        case .invalidURL: return "URL inválida"
        }
    }
}

final class ApiClient {
    static let shared = ApiClient()
    private let baseURL = "http://137.184.53.101:8080/QuePlan/api"
    private let session: URLSession
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        self.session = URLSession(configuration: config)
    }

    func get<T: Decodable>(_ path: String, query: [String: String]? = nil) async throws -> T {
        try await request(method: "GET", path: path, query: query)
    }

    func post<T: Decodable, B: Encodable>(_ path: String, body: B) async throws -> T {
        try await request(method: "POST", path: path, body: body)
    }

    func put<T: Decodable, B: Encodable>(_ path: String, body: B) async throws -> T {
        try await request(method: "PUT", path: path, body: body)
    }

    func delete<T: Decodable>(_ path: String) async throws -> T {
        try await request(method: "DELETE", path: path)
    }

    private func request<T: Decodable>(
        method: String,
        path: String,
        query: [String: String]? = nil,
        body: (any Encodable)? = nil
    ) async throws -> T {
        guard var components = URLComponents(string: "\(baseURL)\(path)") else {
            throw ApiError.invalidURL
        }

        if let query, !query.isEmpty {
            components.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let url = components.url else { throw ApiError.invalidURL }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        if let body {
            request.httpBody = try encoder.encode(AnyEncodable(body))
        }

        let data: Data
        do {
            (data, _) = try await session.data(for: request)
        } catch {
            throw ApiError.networkError(error)
        }

        if let errorResp = try? decoder.decode(ErrorResponse.self, from: data),
           errorResp.response.hasPrefix("Error") || errorResp.response.contains("incorrectos") {
            throw ApiError.serverError(errorResp.response)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw ApiError.decodingError(error)
        }
    }
}

private struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    init(_ wrapped: any Encodable) {
        _encode = { try wrapped.encode(to: $0) }
    }
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
