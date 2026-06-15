//
//  AppSesion.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 14/06/26.
//
import Foundation
import Combine

enum AppDestino {
    case splash
    case welcome
    case businessHome
    case touristHome
}

@MainActor
final class AppSession: ObservableObject {

    @Published var destino: AppDestino = .splash

    // Sesión activa
    @Published var negocio: Negocio?
    @Published var cliente: Cliente?

    private let keyNegocio = "sesion_negocio"
    private let keyCliente = "sesion_cliente"

    init() {
        restaurarSesion()
    }

    // MARK: - Login
    func loginNegocio(_ negocio: Negocio) {
        self.negocio = negocio
        guardar(negocio, key: keyNegocio)
        destino = .businessHome
    }

    func loginCliente(_ cliente: Cliente) {
        self.cliente = cliente
        guardar(cliente, key: keyCliente)
        destino = .touristHome
    }

    // MARK: - Logout
    func logout() {
        negocio = nil
        cliente = nil
        UserDefaults.standard.removeObject(forKey: keyNegocio)
        UserDefaults.standard.removeObject(forKey: keyCliente)
        destino = .welcome
    }

    // MARK: - Sesión persistente
    private func restaurarSesion() {
        if let data = UserDefaults.standard.data(forKey: keyNegocio),
           let saved = try? JSONDecoder().decode(Negocio.self, from: data) {
            negocio = saved
            destino = .businessHome
            return
        }
        if let data = UserDefaults.standard.data(forKey: keyCliente),
           let saved = try? JSONDecoder().decode(Cliente.self, from: data) {
            cliente = saved
            destino = .touristHome
            return
        }
        destino = .welcome
    }

    private func guardar<T: Encodable>(_ value: T, key: String) {
        if let data = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
