//
//  EditActivityViewModel.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 14/06/26.
//

import Foundation
import Combine

@MainActor
final class EditActivityViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var guardadoExitoso = false

    private let service = QueplanService()

    func guardarEvento(
        idNegocio: Int,
        nombre: String,
        descripcion: String,
        cupo: Int,
        ubicacion: String,
        fechaHora: String,
        precio: Double,
        categoria: String,
        tieneEstacionamiento: Int,
        requiereAnticipo: Int,
        montoAnticipo: Double,
        autoconfirmacion: Int,
        imagenes: [String]
    ) async {
        isLoading = true
        errorMessage = nil
        let body = EventoSaveRequest(
            idNegocio: idNegocio,
            nombre: nombre,
            fechaHora: fechaHora,
            ubicacion: ubicacion,
            precio: precio,
            descripcion: descripcion,
            categoria: categoria,
            cupo: cupo,
            tieneEstacionamiento: tieneEstacionamiento,
            requiereAnticipo: requiereAnticipo,
            montoAnticipo: montoAnticipo,
            autoconfirmacion: autoconfirmacion,
            imagenes: imagenes.isEmpty ? nil : imagenes
        )
        do {
            let _ = try await service.crearEvento(body)
            guardadoExitoso = true
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
