import Foundation
import Combine

@MainActor
final class EventosViewModel: ObservableObject {
    @Published var eventos: [Evento] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published var searchText = ""
    @Published var minRating: Double = 0
    @Published var maxPrice: Double = 5000
    @Published var fechaDesde: String?
    @Published var fechaHasta: String?

    private let service = QueplanService()

    var eventosFiltrados: [Evento] {
        var result = eventos

        if !searchText.isEmpty {
            result = result.filter { $0.nombre?.localizedCaseInsensitiveContains(searchText) ?? false }
        }
        if minRating > 0 {
            result = result.filter { ($0.promedioCalificacion ?? 0) >= minRating }
        }
        if maxPrice < 5000 {
            result = result.filter { ($0.precio ?? 0) <= maxPrice }
        }

        return result
    }

    func loadEventos() async {
        isLoading = true
        errorMessage = nil

        do {
            let eventos = try await service.getEventosDisponibles(
                nombre: searchText.isEmpty ? nil : searchText,
                fechaDesde: fechaDesde,
                fechaHasta: fechaHasta
            )
            self.eventos = eventos
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
