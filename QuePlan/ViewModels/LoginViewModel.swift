//
//  LoginViewModel.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 14/06/26.
//
import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var usuario = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published var negocioLogueado: Negocio?
    @Published var clienteLogueado: Cliente?
    @Published var loginExitoso = false

    private let service = QueplanService()

    func loginNegocio() async {
        guard !usuario.isEmpty, !password.isEmpty else {
            errorMessage = "Ingresa usuario y contraseña"
            return
        }
        isLoading = true
        errorMessage = nil
        do {
            let negocio = try await service.loginNegocio(usuario: usuario, password: password)
            if negocio.idNegocio != nil {
                negocioLogueado = negocio
                loginExitoso = true
            } else {
                errorMessage = "Usuario o contraseña incorrectos"
            }
        } catch {
            errorMessage = "Error de conexión. Verifica tu red."
        }
        isLoading = false
    }

    func loginCliente() async {
        guard !usuario.isEmpty, !password.isEmpty else {
            errorMessage = "Ingresa usuario y contraseña"
            return
        }
        isLoading = true
        errorMessage = nil
        do {
            let cliente = try await service.loginCliente(usuario: usuario, password: password)
            if cliente.idCliente != nil {
                clienteLogueado = cliente
                loginExitoso = true
            } else {
                errorMessage = "Usuario o contraseña incorrectos"
            }
        } catch {
            errorMessage = "Error de conexión. Verifica tu red."
        }
        isLoading = false
    }
}
