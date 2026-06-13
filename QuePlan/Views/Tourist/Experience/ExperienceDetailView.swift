import SwiftUI

struct ExperienceDetailView: View {
    let evento: Evento

    @StateObject private var viewModel = DetalleViewModel()
    @State private var showBooking = false
    @State private var isFavorite = false
    @Environment(\.dismiss) var dismiss

    private let clienteId = 1

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    // Hero
                    ZStack(alignment: .bottomLeading) {
                        if let imagenes = viewModel.evento?.imagenes, let first = imagenes.first {
                            AsyncImage(url: URL(string: first)) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 280)
                                        .clipped()
                                default:
                                    Rectangle()
                                        .fill(Color.pink.opacity(0.3))
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 280)
                                }
                            }
                        } else {
                            Rectangle()
                                .fill(Color.pink.opacity(0.3))
                                .frame(maxWidth: .infinity)
                                .frame(height: 280)
                        }

                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [.clear, .black.opacity(0.52)],
                                    startPoint: .top, endPoint: .bottom
                                )
                            )
                            .frame(height: 280)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(viewModel.evento?.nombre ?? evento.nombre ?? "")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                            HStack(spacing: 4) {
                                Text("\(viewModel.evento?.precioFormateado ?? evento.precioFormateado)  ·")
                                Image(systemName: "star.fill").font(.system(size: 12))
                                Text(String(format: "%.1f", viewModel.evento?.promedioCalificacion ?? evento.promedioCalificacion ?? 0))
                            }
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                        }
                        .padding(16)

                        IconButton(
                            systemName: "xmark.circle.fill",
                            size: 36,
                            iconSize: 26,
                            foregroundColor: .white
                        ) { dismiss() }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(12)
                    }

                    // Contenido
                    VStack(alignment: .leading, spacing: 18) {

                        HStack {
                            Text(viewModel.evento?.nombre ?? evento.nombre ?? "")
                                .font(.system(size: 20, weight: .bold))
                            Spacer()
                            IconButton(
                                systemName: isFavorite ? "heart.fill" : "heart",
                                iconSize: 20,
                                foregroundColor: .appPink
                            ) { isFavorite.toggle() }
                        }

                        Text(viewModel.evento?.descripcion ?? evento.descripcion ?? "")
                            .font(.system(size: 14))
                            .foregroundColor(.appTextSecondary)
                            .lineSpacing(4)

                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.appPink)
                                .font(.system(size: 18))
                            Text(viewModel.evento?.ubicacion ?? evento.ubicacion ?? "")
                                .font(.system(size: 14))
                                .foregroundColor(.appTextSecondary)
                        }

                        if let fecha = viewModel.evento?.fechaHora ?? evento.fechaHora {
                            HStack(spacing: 10) {
                                Image(systemName: "calendar")
                                    .foregroundColor(.appPink)
                                Text(fecha)
                                    .font(.system(size: 14))
                                    .foregroundColor(.appTextSecondary)
                            }
                        }

                        // Galería
                        if let imagenes = viewModel.evento?.imagenes, imagenes.count > 1 {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(Array(imagenes.dropFirst().enumerated()), id: \.offset) { _, url in
                                        AsyncImage(url: URL(string: url)) { phase in
                                            switch phase {
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 140, height: 110)
                                                    .cornerRadius(12)
                                                    .clipped()
                                            default:
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(Color.appGray)
                                                    .frame(width: 140, height: 110)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        PrimaryButton(title: "Quiero inscribirme") { showBooking = true }

                        // Opiniones
                        if !viewModel.opiniones.isEmpty {
                            Text("Opiniones")
                                .font(.system(size: 18, weight: .bold))

                            ForEach(Array(viewModel.opiniones.enumerated()), id: \.element.id) { index, opinion in
                                ReviewRow(
                                    userName: opinion.nombreCliente ?? "Anónimo",
                                    experienceName: viewModel.evento?.nombre ?? "",
                                    comment: opinion.comentario ?? "",
                                    rating: Double(opinion.calificacion ?? 0)
                                )
                                if index < viewModel.opiniones.count - 1 { Divider() }
                            }
                        }
                    }
                    .padding(16)
                    .padding(.bottom, 30)
                }
            }
            .background(Color.white)
            .ignoresSafeArea(edges: .top)
            .navigationBarHidden(true)
            .sheet(isPresented: $showBooking) {
                BookingView(evento: viewModel.evento ?? evento)
            }
        }
        .task {
            if let id = evento.idEvento {
                await viewModel.load(idEvento: id)
            }
        }
    }
}
