//
//  ActivityDetailView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct ActivityDetailView: View {
    let idEvento: Int

    @StateObject private var vm = ActivityDetailViewModel()
    @State private var showEdit = false
    @State private var showCancelConfirm = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {

                ZStack(alignment: .topTrailing) {
                    if let imagenes = vm.evento?.imagenes,
                       let primera = imagenes.first,
                       let url = URL(string: primera) {
                        AsyncImage(url: url) { img in
                            img.resizable().scaledToFill()
                        } placeholder: {
                            Rectangle().fill(Color.gray.opacity(0.3))
                                .overlay(Image(systemName: "photo")
                                    .font(.system(size: 44))
                                    .foregroundColor(.white.opacity(0.4)))
                        }
                        .frame(height: 240).clipped()
                    } else {
                        Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 240)
                            .overlay(Image(systemName: "photo")
                                .font(.system(size: 44))
                                .foregroundColor(.white.opacity(0.4)))
                    }

                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 28)).foregroundColor(.white)
                    }
                    .padding(16)
                }

                if vm.isLoading {
                    ProgressView().frame(maxWidth: .infinity).padding(.top, 40)
                } else {
                    VStack(alignment: .leading, spacing: 16) {

                        HStack {
                            Text(vm.evento?.nombre ?? "Actividad")
                                .font(.system(size: 20, weight: .bold))
                            Spacer()
                            Button { showEdit = true } label: {
                                Image(systemName: "pencil.circle")
                                    .font(.system(size: 24)).foregroundColor(.appPink)
                            }
                        }

                        Text(vm.evento?.descripcion ?? "")
                            .font(.system(size: 14))
                            .foregroundColor(.appTextSecondary)
                            .lineSpacing(4)

                        if let cupo = vm.evento?.cupo {
                            Text("Cupo: \(cupo) personas")
                                .font(.system(size: 14)).foregroundColor(.appTextSecondary)
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            if let ubicacion = vm.evento?.ubicacion {
                                InfoDetailRow(icon: "mappin.circle", text: ubicacion)
                            }
                            if let fecha = vm.evento?.fechaFormateada {
                                InfoDetailRow(icon: "calendar.circle", text: fecha)
                            }
                            if let hora = vm.evento?.horaFormateada {
                                InfoDetailRow(icon: "clock.circle", text: hora)
                            }
                            InfoDetailRow(icon: "dollarsign.circle",
                                          text: vm.evento?.precioFormateado ?? "")
                        }

                        Divider()

                        //reservas
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Personas interesadas")
                                .font(.system(size: 16, weight: .bold))

                            if vm.reservas.isEmpty {
                                Text("Sin reservas aún")
                                    .font(.system(size: 14))
                                    .foregroundColor(.appTextSecondary)
                            } else {
                                ForEach(vm.reservas) { reserva in
                                    ParticipantRow(
                                        name: reserva.nombreCliente ?? "Cliente",
                                        spots: reserva.cantidadPersonas ?? 1,
                                        status: estadoReserva(reserva.estado)
                                    )
                                }
                            }
                        }

                        if let error = vm.errorMessage {
                            Text(error).font(.system(size: 13)).foregroundColor(.red)
                        }
                    }
                    .padding(16).padding(.bottom, 30)
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarHidden(true)
        .sheet(isPresented: $showEdit) {
            if let evento = vm.evento {
                EditActivityView(evento: evento)
            }
        }
        .overlay {
            if showCancelConfirm {
                CancelConfirmModal(
                    onConfirm: {
                        showCancelConfirm = false
                        Task { await vm.cancelarEvento() }
                    },
                    onDismiss: { showCancelConfirm = false }
                )
            }
            if vm.canceladoExitoso {
                CancelSuccessModal { dismiss() }
            }
        }
        .task { await vm.load(idEvento: idEvento) }
    }

    private func estadoReserva(_ estado: String?) -> ParticipantStatus {
        switch estado {
        case "confirmada": return .accepted
        case "cancelada":  return .rejected
        default:           return .pending
        }
    }
}
