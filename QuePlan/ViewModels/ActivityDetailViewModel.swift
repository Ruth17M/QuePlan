//
//  ActivityDetailViewModel.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 14/06/26.
//

import Foundation
import Combine

@MainActor
final class ActivityDetailViewModel: ObservableObject {
    @Published var evento: Evento?
    @Published var reservas: [Reserva] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var canceladoExitoso = false

    private let service = QueplanService()

    func load(idEvento: Int) async {
        isLoading = true
        errorMessage = nil
        do {
            async let evento = service.getEvento(id: idEvento)
            async let reservas = service.getReservasNegocioEvento(idEvento: idEvento)
            (self.evento, self.reservas) = try await (evento, reservas)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func confirmarReserva(id: Int) async {
        do {
            try await service.confirmarReserva(id: id)
            // Recargar reservas
            if let idEvento = evento?.idEvento {
                reservas = try await service.getReservasNegocioEvento(idEvento: idEvento)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func cancelarReserva(id: Int) async {
        do {
            try await service.cancelarReserva(id: id)
            if let idEvento = evento?.idEvento {
                reservas = try await service.getReservasNegocioEvento(idEvento: idEvento)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func cancelarEvento() async {
        guard let id = evento?.idEvento else { return }
        isLoading = true
        do {
            let _ = try await service.cancelarEvento(id: id)
            canceladoExitoso = true
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
