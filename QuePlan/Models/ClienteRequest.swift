//
//  ClienteRequest.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 14/06/26.
//

import Foundation

struct Cliente: Codable {
    let idCliente: Int?
    let usuario: String?
    let nombre: String?
    let telefono: String?
    let imagenUrl: String?
}

struct ClienteLoginRequest: Codable {
    let usuario: String
    let passwordHash: String
}

struct ClienteRegistroRequest: Codable {
    let usuario: String
    let nombre: String
    let telefono: String
    let passwordHash: String
    let imagenUrl: String?
}
