import Foundation

@MainActor
final class DetalleViewModel: ObservableObject {
    @Published var evento: Evento?
    @Published var opiniones: [Opinion] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func load(idEvento: Int) async {
        isLoading = true
        errorMessage = nil

        do {
            async let eventoData: Evento = ApiClient.shared.get("/evento/get/\(idEvento)")
            async let opinionesData: [Opinion] = ApiClient.shared.get("/opinion/getByEvento/\(idEvento)")
            (evento, opiniones) = try await (eventoData, opinionesData)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
