//
//  ActivityDetailView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI


struct ActivityDetailView: View {
    @State private var showEdit = false
    @State private var showCancelConfirm = false
    @State private var showCancelSuccess = false
    @Environment(\.dismiss) var dismiss
 
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
 
                ZStack(alignment: .topTrailing) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 240)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.system(size: 44)).foregroundColor(.white.opacity(0.4))
                        )
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 28)).foregroundColor(.white)
                    }
                    .padding(16)
                }
 
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Pinta tu Tote")
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                        Button { showEdit = true } label: {
                            Image(systemName: "pencil.circle")
                                .font(.system(size: 24)).foregroundColor(.appPink)
                        }
                    }
 
                    Text("Ven con tu familia o amigos a esta actividad recreativa donde podrás personalizar tu propia totebag.")
                        .font(.system(size: 14)).foregroundColor(.appTextSecondary).lineSpacing(4)
 
                    Text("Cupo: 30 personas")
                        .font(.system(size: 14)).foregroundColor(.appTextSecondary)
 
                    VStack(alignment: .leading, spacing: 10) {
                        InfoDetailRow(icon: "mappin.circle", text: "Blvd. Miguel de Cervantes Saavedra, Granada, Miguel Hidalgo, 11529 Ciudad de México, CDMX")
                        InfoDetailRow(icon: "calendar.circle", text: "Domingo 15 de marzo")
                        InfoDetailRow(icon: "clock.circle", text: "16:00 - 18:00")
                        InfoDetailRow(icon: "dollarsign.circle", text: "$100 c/persona")
                    }
 
                    HStack(spacing: 10) {
                        ForEach(0..<2, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.appGray).frame(height: 90)
                        }
                    }
 
                    Divider()
 
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Personas interesadas")
                                .font(.system(size: 16, weight: .bold))
                            Spacer()
                            Text("Cupo: 18 lugares restantes")
                                .font(.system(size: 12)).foregroundColor(.appPink)
                        }
 
                        ParticipantRow(name: "Camila Liedo", spots: 4, status: .rejected)
                        ParticipantRow(name: "Camila Liedo", spots: 4, status: .accepted)
                        ParticipantRow(name: "Camila Liedo", spots: 4, status: .pending)
                        ParticipantRow(name: "Camila Liedo", spots: 4, status: .pending)
                    }
                }
                .padding(16).padding(.bottom, 30)
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarHidden(true)
        .sheet(isPresented: $showEdit) { EditActivityView() }
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
    }
}
