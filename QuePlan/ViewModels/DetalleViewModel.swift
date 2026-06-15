import Foundation
import Combine

@MainActor
final class DetalleViewModel: ObservableObject {
    @Published var evento: Evento?
    @Published var opiniones: [Opinion] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = QueplanService()

    func load(idEvento: Int) async {
        isLoading = true
        errorMessage = nil

        do {
            async let evento = service.getEvento(id: idEvento)
            async let opiniones = service.getOpiniones(idEvento: idEvento)
            (self.evento, self.opiniones) = try await (evento, opiniones)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
