//
//  NegocioRequest.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 14/06/26.
//

import Foundation

struct NegocioLoginRequest: Codable {
    let usuario: String
    let passwordHash: String
}

struct NegocioRegistroRequest: Codable {
    let usuario: String
    let nombreNegocio: String
    let nombreDueno: String
    let direccion: String
    let telefono: String
    let descripcion: String
    let logoUrl: String?
    let passwordHash: String
    let instagram: String?
    let facebook: String?
    let tiktok: String?
    let paginaWeb: String?
}

struct NegocioActualizarRequest: Codable {
    let idNegocio: Int
    let descripcion: String?
    let logoUrl: String?
    let telefono: String?
    let direccion: String?
    let instagram: String?
    let facebook: String?
    let tiktok: String?
    let paginaWeb: String?
}
