//
//  BusinessRegisterViewModel.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 14/06/26.
//

import Foundation
import Combine

@MainActor
final class BusinessRegisterViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var registroExitoso = false
    @Published var negocioRegistrado: Negocio?

    private let service = QueplanService()

    func registrar(
        usuario: String,
        nombreNegocio: String,
        nombreDueno: String,
        descripcion: String,
        direccion: String,
        telefono: String,
        password: String,
        tiktok: String,
        instagram: String,
        facebook: String
    ) async {
        guard !usuario.isEmpty, !password.isEmpty, !nombreNegocio.isEmpty else {
            errorMessage = "Usuario, nombre del negocio y contraseña son obligatorios"
            return
        }
        isLoading = true
        errorMessage = nil
        let body = NegocioRegistroRequest(
            usuario: usuario,
            nombreNegocio: nombreNegocio,
            nombreDueno: nombreDueno,
            direccion: direccion,
            telefono: telefono,
            descripcion: descripcion,
            logoUrl: nil,
            passwordHash: password,
            instagram: instagram.isEmpty ? nil : instagram,
            facebook: facebook.isEmpty ? nil : facebook,
            tiktok: tiktok.isEmpty ? nil : tiktok,
            paginaWeb: nil
        )
        do {
            let negocio = try await service.registrarNegocio(body)
            if negocio.idNegocio != nil {
                negocioRegistrado = negocio
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
