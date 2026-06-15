//
//  EventoRequest.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 14/06/26.
//

import Foundation

struct EventoSaveRequest: Codable {
    let idNegocio: Int
    let nombre: String
    let fechaHora: String
    let ubicacion: String
    let precio: Double
    let descripcion: String
    let categoria: String
    let cupo: Int
    let tieneEstacionamiento: Int
    let requiereAnticipo: Int
    let montoAnticipo: Double
    let autoconfirmacion: Int
    let imagenes: [String]?
}

struct CancelEventoResponse: Codable {
    let response: String
    let afectados: [Reserva]?
}
