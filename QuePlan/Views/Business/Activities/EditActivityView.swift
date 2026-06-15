//
//  EditActivityView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct EditActivityView: View {
    let evento: Evento                  

    @StateObject private var vm = EditActivityViewModel()
    @State private var actName: String
    @State private var actDesc: String
    @State private var capacity: String
    @State private var address: String
    @State private var schedule: String
    @State private var price: String
    @State private var showCancelConfirm = false
    @State private var showCancelSuccess = false
    @Environment(\.dismiss) var dismiss

    init(evento: Evento) {
        self.evento = evento
        _actName    = State(initialValue: evento.nombre ?? "")
        _actDesc    = State(initialValue: evento.descripcion ?? "")
        _capacity   = State(initialValue: "\(evento.cupo ?? 0)")
        _address    = State(initialValue: evento.ubicacion ?? "")
        _schedule   = State(initialValue: evento.horaFormateada)
        _price      = State(initialValue: "\(Int(evento.precio ?? 0))")
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                // Hero editable
                ZStack {
                    Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 200)
                    VStack(spacing: 6) {
                        Image(systemName: "camera.fill").font(.system(size: 28)).foregroundColor(.white)
                        Text("Cambiar imagen").font(.system(size: 14, weight: .medium)).foregroundColor(.white)
                    }
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill").font(.system(size: 26)).foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(12)
                }

                VStack(alignment: .leading, spacing: 18) {
                    EditField(label: "Nombre de la actividad", text: $actName)
                    EditField(label: "Descripción", text: $actDesc, multiline: true)
                    EditField(label: "Cupo", text: $capacity)
                    EditField(label: "Dirección", text: $address, multiline: true)
                    EditField(label: "Horario (HH:MM:SS)", text: $schedule)
                    EditField(label: "Precio por persona", text: $price)

                    Button { showCancelConfirm = true } label: {
                        Text("Cancelar actividad")
                            .font(.system(size: 14, weight: .medium)).foregroundColor(.red)
                    }

                    if let error = vm.errorMessage {
                        Text(error).font(.system(size: 13)).foregroundColor(.red)
                    }

                    if vm.isLoading {
                        ProgressView().frame(maxWidth: .infinity)
                    } else {
                        PrimaryButton(title: "Guardar cambios") {
                            Task {
                                await vm.guardarEvento(
                                    idNegocio: evento.idNegocio ?? 0,
                                    nombre: actName,
                                    descripcion: actDesc,
                                    cupo: Int(capacity) ?? 0,
                                    ubicacion: address,
                                    fechaHora: "\(evento.fechaFormateada) \(schedule)",
                                    precio: Double(price) ?? 0,
                                    categoria: evento.categoria ?? "",
                                    tieneEstacionamiento: evento.tieneEstacionamiento ?? 0,
                                    requiereAnticipo: evento.requiereAnticipo ?? 0,
                                    montoAnticipo: evento.montoAnticipo ?? 0,
                                    autoconfirmacion: evento.autoconfirmacion ?? 0,
                                    imagenes: evento.imagenes ?? []
                                )
                            }
                        }
                        .padding(.top, 8)
                    }
                }
                .padding(16).padding(.bottom, 40)
            }
        }
        .ignoresSafeArea(edges: .top)
        .overlay {
            if showCancelConfirm {
                CancelConfirmModal(
                    onConfirm: { showCancelConfirm = false; showCancelSuccess = true },
                    onDismiss: { showCancelConfirm = false }
                )
            }
            if showCancelSuccess {
                CancelSuccessModal { showCancelSuccess = false; dismiss() }
            }
        }
        .onChange(of: vm.guardadoExitoso) { ok in if ok { dismiss() } }
    }
}

private struct EditField: View {
    let label: String
    @Binding var text: String
    var multiline = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label).font(.system(size: 13, weight: .medium)).foregroundColor(.appTextSecondary)
            if multiline {
                TextEditor(text: $text)
                    .font(.system(size: 14)).frame(minHeight: 72)
                    .padding(8).background(Color.appGray).cornerRadius(10)
            } else {
                AppTextField(placeholder: label, text: $text)
            }
        }
    }
}
