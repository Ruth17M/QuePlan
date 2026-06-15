//
//  BusinessHomeViewModel.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.

import Foundation
import Combine

@MainActor
final class BusinessHomeViewModel: ObservableObject {

    // MARK: - Published state
    @Published var negocio: Negocio?
    @Published var eventos: [Evento] = []
    @Published var eventosDelDia: [Evento] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published var diaSeleccionado: Int = Calendar.current.component(.day, from: Date()) {
        didSet { filtrarEventosDelDia(dia: diaSeleccionado) }
    }

    @Published var currentMonth: Date = Date() {
        didSet { filtrarEventosDelDia(dia: diaSeleccionado) }
    }

    // MARK: - Session
    private let sessionKey = "negocio_session"
    private let api = ApiClient.shared

    init() {
        loadSession()
    }

    // MARK: - Login

    func login(usuario: String, password: String) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        struct LoginBody: Encodable {
            let usuario: String
            let passwordHash: String
        }

        do {
            let result: Negocio = try await api.post(
                "/negocio/login",
                body: LoginBody(usuario: usuario, passwordHash: password)
            )
            negocio = result
            saveSession(result)
            await fetchEventos()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Fetch eventos

    func fetchEventos() async {
        guard let id = negocio?.idNegocio else { return }
        isLoading = true
        defer { isLoading = false }

        do {
            let result: [Evento] = try await api.get("/evento/getAll/\(id)")
            eventos = result
            filtrarEventosDelDia(dia: diaSeleccionado)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Filtrar por día

    func filtrarEventosDelDia(dia: Int) {
        let cal = Calendar.current
        let mesRef = cal.dateComponents([.month, .year], from: currentMonth)

        eventosDelDia = eventos.filter { evento in
            guard let fecha = evento.fechaDate else { return false }
            let comp = cal.dateComponents([.day, .month, .year], from: fecha)
            return comp.day == dia
                && comp.month == mesRef.month
                && comp.year == mesRef.year
        }
    }

    // MARK: - Días con eventos (para resaltar calendario)

    var diasConEventos: Set<Int> {
        let cal = Calendar.current
        let mesRef = cal.dateComponents([.month, .year], from: currentMonth)

        return Set(eventos.compactMap { evento -> Int? in
            guard let fecha = evento.fechaDate else { return nil }
            let comp = cal.dateComponents([.day, .month, .year], from: fecha)
            guard comp.month == mesRef.month, comp.year == mesRef.year else { return nil }
            return comp.day
        })
    }

    // MARK: - Saludo

    var nombreSaludo: String {
        negocio?.nombreNegocio ?? negocio?.nombreDueno ?? "Negocio"
    }

    // MARK: - Sesión persistente

    private func saveSession(_ negocio: Negocio) {
        guard let data = try? JSONEncoder().encode(negocio) else { return }
        UserDefaults.standard.set(data, forKey: sessionKey)
    }

    private func loadSession() {
        guard
            let data = UserDefaults.standard.data(forKey: sessionKey),
            let saved = try? JSONDecoder().decode(Negocio.self, from: data)
        else { return }
        negocio = saved
        Task { await fetchEventos() }
    }

    func logout() {
        negocio = nil
        eventos = []
        eventosDelDia = []
        UserDefaults.standard.removeObject(forKey: sessionKey)
    }
}

// MARK: - Extensión para parsear fecha (añadir a Evento.swift si prefieres)

extension Evento {
    var fechaDate: Date? {
        guard let fechaHora else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "es_MX")
        return formatter.date(from: fechaHora)
    }

    var diaMes: Int {
        Calendar.current.component(.day, from: fechaDate ?? Date())
    }
}
