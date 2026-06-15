//
//  BusinessHomeViewModel.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.

import Foundation
import Combine

@MainActor
final class BusinessHomeViewModel: ObservableObject {

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

    private let service = QueplanService()
    private let sessionKey = "sesion_negocio"

    init() { loadSession() }

//fetch de eventos
    func fetchEventos() async {
        guard let id = negocio?.idNegocio else { return }
        isLoading = true
        errorMessage = nil
        do {
            let result = try await service.getEventosNegocio(idNegocio: id)
            eventos = result
            filtrarEventosDelDia(dia: diaSeleccionado)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

//filtrado por día
    func filtrarEventosDelDia(dia: Int) {
        let cal = Calendar.current
        let mesRef = cal.dateComponents([.month, .year], from: currentMonth)
        eventosDelDia = eventos.filter { evento in
            guard let fecha = evento.fechaDate else { return false }
            let comp = cal.dateComponents([.day, .month, .year], from: fecha)
            return comp.day == dia && comp.month == mesRef.month && comp.year == mesRef.year
        }
    }

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

    var nombreSaludo: String {
        negocio?.nombreNegocio ?? negocio?.nombreDueno ?? "Negocio"
    }

//sesión
    private func loadSession() {
        guard
            let data = UserDefaults.standard.data(forKey: sessionKey),
            let saved = try? JSONDecoder().decode(Negocio.self, from: data)
        else { return }
        negocio = saved
        Task { await fetchEventos() }
    }

    func guardarSesion(_ negocio: Negocio) {
        self.negocio = negocio
        if let data = try? JSONEncoder().encode(negocio) {
            UserDefaults.standard.set(data, forKey: sessionKey)
        }
        Task { await fetchEventos() }
    }

    func logout() {
        negocio = nil
        eventos = []
        eventosDelDia = []
        UserDefaults.standard.removeObject(forKey: sessionKey)
    }
}
