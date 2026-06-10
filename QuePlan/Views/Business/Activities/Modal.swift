//
//  Modal.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI


struct CancelConfirmModal: View {
    var onConfirm: () -> Void = {}
    var onDismiss: () -> Void = {}
 
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            VStack(spacing: 20) {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 56)).foregroundColor(.orange)
                Text("¿Deseas cancelar esta actividad?")
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.center)
                HStack(spacing: 20) {
                    Button("Sí") { onConfirm() }
                        .font(.system(size: 15, weight: .medium))
                        .frame(width: 80, height: 40)
                        .background(Color.appGray).cornerRadius(10)
                        .foregroundColor(.appTextPrimary)
                    Button("No") { onDismiss() }
                        .font(.system(size: 15, weight: .medium))
                        .frame(width: 80, height: 40)
                        .background(Color.appGray).cornerRadius(10)
                        .foregroundColor(.appTextPrimary)
                }
            }
            .padding(32).background(Color.white).cornerRadius(20)
            .padding(.horizontal, 40)
        }
    }
}




struct CancelSuccessModal: View {
    var onDismiss: () -> Void = {}
 
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            VStack(spacing: 14) {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 56)).foregroundColor(.red)
                Text("¡Cancelada!")
                    .font(.system(size: 20, weight: .bold))
                Text("Actividad cancelada con éxito")
                    .font(.system(size: 14)).foregroundColor(.appTextSecondary)
            }
            .padding(32).background(Color.white).cornerRadius(20)
            .padding(.horizontal, 40)
            .onTapGesture { onDismiss() }
        }
    }
}
