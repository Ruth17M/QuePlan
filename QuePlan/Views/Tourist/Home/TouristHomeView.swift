import SwiftUI

struct TouristHomeView: View {
    @StateObject private var viewModel = EventosViewModel()
    @State private var showFilter = false

    private let clienteId = 1

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Hola, Ruth")
                                .font(.system(size: 24, weight: .bold))
                            Text("Descubre, reserva y vive experiencias.")
                                .font(.system(size: 14))
                                .foregroundColor(.appTextSecondary)
                        }
                        Spacer()
                        AvatarView(size: 46)
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)

                    // Búsqueda + botón filtros
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.appTextSecondary)
                        TextField("Buscar actividades...", text: $viewModel.searchText)
                            .font(.system(size: 15))
                            .onSubmit { Task { await viewModel.loadEventos() } }
                        Spacer()
                        IconButton(
                            systemName: "line.3.horizontal.decrease",
                            size: 42,
                            iconSize: 16,
                            foregroundColor: .white,
                            backgroundColor: .appPink
                        ) { showFilter = true }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(Color.appGray)
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // Título sección
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Todos tus planes en un solo lugar")
                            .font(.system(size: 18, weight: .bold))
                        Rectangle()
                            .fill(Color.appPink)
                            .frame(height: 2)
                    }
                    .padding(.horizontal)

                    // Estado de carga
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                    }

                    // Error
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }

                    // Lista de experiencias
                    LazyVStack(spacing: 14) {
                        ForEach(viewModel.eventosFiltrados) { evento in
                            NavigationLink(destination: ExperienceDetailView(evento: evento)) {
                                ExperienceCard(
                                    title: evento.nombre ?? "Sin nombre",
                                    price: evento.precioFormateado,
                                    rating: evento.promedioCalificacion ?? 0
                                )
                                .padding(.horizontal)
                            }
                            .buttonStyle(.plain)
                        }

                        if viewModel.eventosFiltrados.isEmpty && !viewModel.isLoading {
                            Text("No se encontraron actividades")
                                .font(.system(size: 15))
                                .foregroundColor(.appTextSecondary)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 40)
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            .background(Color.white)
            .sheet(isPresented: $showFilter) {
                FilterSheetView(
                    minRating: $viewModel.minRating,
                    maxPrice: $viewModel.maxPrice
                )
            }
            .task { await viewModel.loadEventos() }
        }
    }
}
