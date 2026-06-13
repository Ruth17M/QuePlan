import SwiftUI

struct BookingView: View {
    let evento: Evento

    @StateObject private var viewModel = ReservaViewModel()
    @State private var people = 1
    @Environment(\.dismiss) var dismiss

    private let clienteId = 1

    var body: some View {
        VStack(spacing: 0) {

            // Mini hero
            ZStack(alignment: .bottomLeading) {
                if let imagenes = evento.imagenes, let first = imagenes.first {
                    AsyncImage(url: URL(string: first)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                                .clipped()
                        default:
                            Rectangle()
                                .fill(Color.pink.opacity(0.28))
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                        }
                    }
                } else {
                    Rectangle()
                        .fill(Color.pink.opacity(0.28))
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(evento.nombre ?? "")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    HStack(spacing: 4) {
                        Text("\(evento.precioFormateado)  ·")
                        Image(systemName: "star.fill").font(.system(size: 11))
                        Text(String(format: "%.1f", evento.promedioCalificacion ?? 0))
                    }
                    .font(.system(size: 13))
                    .foregroundColor(.white)
                }
                .padding(14)

                IconButton(
                    systemName: "xmark.circle.fill",
                    size: 32,
                    iconSize: 24,
                    foregroundColor: .white
                ) { dismiss() }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(12)
            }

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {

                    Text("Asegura tu lugar")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.appPink)
                        .frame(maxWidth: .infinity)

                    Text("Detalles")
                        .font(.system(size: 16, weight: .semibold))

                    // Fecha
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 6) {
                            Image(systemName: "calendar").foregroundColor(.appPink)
                            Text("Fecha")
                                .font(.system(size: 13))
                                .foregroundColor(.appTextSecondary)
                        }
                        Text(evento.fechaFormateada)
                            .font(.system(size: 15))
                    }

                    // Horario
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 6) {
                            Image(systemName: "clock").foregroundColor(.appPink)
                            Text("Horario")
                                .font(.system(size: 13))
                                .foregroundColor(.appTextSecondary)
                        }
                        Text(evento.horaFormateada.isEmpty ? "Por definir" : evento.horaFormateada)
                            .font(.system(size: 15))
                    }

                    // Precio
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 6) {
                            Image(systemName: "dollarsign.circle").foregroundColor(.appPink)
                            Text("Precio")
                                .font(.system(size: 13))
                                .foregroundColor(.appTextSecondary)
                        }
                        Text(evento.precioFormateado)
                            .font(.system(size: 15))
                    }

                    // Número de personas
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Número de personas")
                            .font(.system(size: 13))
                            .foregroundColor(.appTextSecondary)
                        HStack(spacing: 20) {
                            Button {
                                if people > 1 { people -= 1 }
                            } label: {
                                Image(systemName: "minus.circle")
                                    .font(.system(size: 28))
                                    .foregroundColor(Color.appGrayMid)
                            }
                            Text("\(people)")
                                .font(.system(size: 20, weight: .semibold))
                                .frame(width: 28, alignment: .center)
                            Button { people += 1 } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 28))
                                    .foregroundColor(.appPink)
                            }
                        }
                    }

                    // Mensaje de confirmación
                    if viewModel.success {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("¡Reserva confirmada!")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.green)
                        }
                        .padding(.vertical, 8)
                    }

                    // Error
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .font(.system(size: 13))
                            .foregroundColor(.red)
                    }
                }
                .padding()
            }

            // Botones footer
            VStack(spacing: 10) {
                PrimaryButton(title: viewModel.success ? "Listo" : "Continuar") {
                    if viewModel.success {
                        dismiss()
                    } else {
                        Task {
                            await viewModel.reservar(
                                idCliente: clienteId,
                                idEvento: evento.idEvento ?? 0,
                                cantidadPersonas: people
                            )
                        }
                    }
                }
                .disabled(viewModel.isLoading)

                if viewModel.isLoading {
                    ProgressView()
                }

                if !viewModel.success {
                    Button("Cancelar") { dismiss() }
                        .font(.system(size: 15))
                        .foregroundColor(.appTextSecondary)
                }
            }
            .padding()
        }
        
        .ignoresSafeArea(edges: .top)
        
        // RESERVA CONFIRMADA
        .overlay(
            Group {
                if viewModel.success {
                    Color.black.opacity(0.45)
                        .ignoresSafeArea()
                        .overlay(
                            VStack(spacing: 16) {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 72))
                                    .foregroundColor(.green)
                                Text("¡Reserva confirmada!")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                                Text(evento.nombre ?? "")
                                    .font(.system(size: 15))
                                    .foregroundColor(.white.opacity(0.8))
                            }
                        )
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                dismiss()
                            }
                        }
                }
            }
        )
    }
}
