//
//  TouristRegisterViewModel.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 15/06/26.
//

import Foundation
import Combine

@MainActor
final class TouristRegisterViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var registroExitoso = false
    @Published var clienteRegistrado: Cliente?

    private let service = QueplanService()

    func registrar(
        usuario: String,      // ← parámetro agregado
        nombre: String,
        telefono: String,
        password: String
    ) async {
        guard !usuario.isEmpty, !nombre.isEmpty, !password.isEmpty else {
            errorMessage = "Usuario, nombre y contraseña son obligatorios"
            return
        }
        isLoading = true
        errorMessage = nil
        let body = ClienteRegistroRequest(
            usuario: usuario,   // ← ya no usa el teléfono como usuario
            nombre: nombre,
            telefono: telefono,
            passwordHash: password,
            imagenUrl: nil
        )
        do {
            let cliente = try await service.registrarCliente(body)
            if cliente.idCliente != nil {
                clienteRegistrado = cliente
                registroExitoso = true
            } else {
                errorMessage = "No se pudo crear la cuenta. Intenta con otro usuario."
            }
        } catch {
            errorMessage = "Error de conexión. Verifica tu red."
        }
        isLoading = false
    }
}
