//
//  EditActivityView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct EditActivityView: View {
    @State private var actName = "Pinta tu Tote"
    @State private var actDesc = "Ven con tu familia o amigos a esta actividad recreativa donde podrás personalizar tu propia totebag."
    @State private var capacity = "30"
    @State private var address = "Blvd. Miguel de Cervantes Saavedra, Granada, Miguel Hidalgo, 11529 Ciudad de México, CDMX"
    @State private var schedule = "16:00 - 18:00"
    @State private var price = "100"
    @State private var showCancelConfirm = false
    @State private var showCancelSuccess = false
    @Environment(\.dismiss) var dismiss
 
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
 
                // Hero editable
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3)).frame(height: 200)
                    VStack(spacing: 6) {
                        Image(systemName: "camera.fill")
                            .font(.system(size: 28)).foregroundColor(.white)
                        Text("Cambiar imagen")
                            .font(.system(size: 14, weight: .medium)).foregroundColor(.white)
                    }
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 26)).foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(12)
                }
 
                VStack(alignment: .leading, spacing: 18) {
                    EditField(label: "Nombre de la actividad", text: $actName)
                    EditField(label: "Descripción de la actividad", text: $actDesc, multiline: true)
                    EditField(label: "Cupo de la actividad", text: $capacity)
                    EditField(label: "Dirección de la actividad", text: $address, multiline: true)
                    EditField(label: "Horario de la actividad", text: $schedule)
                    EditField(label: "Precio por persona", text: $price)
 
                    Button { showCancelConfirm = true } label: {
                        Text("Cancelar actividad")
                            .font(.system(size: 14, weight: .medium)).foregroundColor(.red)
                    }
 
                    // Galería editable
                    HStack(spacing: 10) {
                        ForEach(0..<2, id: \.self) { _ in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.appGray).frame(height: 90)
                                VStack(spacing: 4) {
                                    Image(systemName: "camera.fill")
                                        .foregroundColor(.appTextSecondary)
                                    Text("Cambiar imagen")
                                        .font(.system(size: 11)).foregroundColor(.appTextSecondary)
                                }
                            }
                        }
                    }
 
                    Text("Usuarios registrados")
                        .font(.system(size: 16, weight: .semibold))
 
                    ForEach(0..<3, id: \.self) { _ in
                        ParticipantRow(name: "Camila Liedo", spots: 4, status: .pending)
                    }
 
                    PrimaryButton(title: "Guardar cambios") { dismiss() }
                        .padding(.top, 8)
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
    }
}

private struct EditField: View {
    let label: String
    @Binding var text: String
    var multiline = false
 
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.appTextSecondary)
            if multiline {
                TextEditor(text: $text)
                    .font(.system(size: 14))
                    .frame(minHeight: 72)
                    .padding(8)
                    .background(Color.appGray)
                    .cornerRadius(10)
            } else {
                AppTextField(placeholder: label, text: $text)
            }
        }
    }
}
