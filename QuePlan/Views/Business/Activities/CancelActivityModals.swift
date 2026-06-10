//
//  CancelActivityModals.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//
import SwiftUI

struct CancelActivityModal: View {
    @Binding var isPresented: Bool
    @State private var confirmed = false
    var onCancelled: () -> Void = {}   // callback tras confirmar cancelación
 
    var body: some View {
        ZStack {
            // Fondo oscuro — toca fuera para cerrar solo en paso 1
            Color.black.opacity(0.45)
                .ignoresSafeArea()
                .onTapGesture { if !confirmed { isPresented = false } }
 
            if !confirmed {
                // PASO 1: confirmar
                ConfirmCard(
                    onYes: {
                        withAnimation(.easeInOut(duration: 0.2)) { confirmed = true }
                    },
                    onNo: { isPresented = false }
                )
            } else {
                // PASO 2: éxito
                SuccessCard {
                    isPresented = false
                    onCancelled()
                }
                .transition(.scale(scale: 0.85).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: confirmed)
    }
}

private struct ConfirmCard: View {
    let onYes: () -> Void
    let onNo: () -> Void
 
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "info.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.orange)
 
            Text("¿Deseas cancelar\nesta actividad?")
                .font(.system(size: 17, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(.appTextPrimary)
 
            HStack(spacing: 16) {
                // Sí — confirma cancelación
                Button(action: onYes) {
                    Text("Sí")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.appTextPrimary)
                        .frame(width: 88, height: 42)
                        .background(Color.appGray)
                        .cornerRadius(10)
                }
                // No — cierra el modal
                Button(action: onNo) {
                    Text("No")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.appTextPrimary)
                        .frame(width: 88, height: 42)
                        .background(Color.appGray)
                        .cornerRadius(10)
                }
            }
        }
        .padding(32)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 44)
    }
}
 
// MARK: - SuccessCard (privado)
private struct SuccessCard: View {
    let onDismiss: () -> Void
 
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "xmark.circle")
                .font(.system(size: 60))
                .foregroundColor(.red)
 
            Text("¡Cancelada!")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.appTextPrimary)
 
            Text("Actividad cancelada con éxito")
                .font(.system(size: 14))
                .foregroundColor(.appTextSecondary)
        }
        .padding(36)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 44)
        .onTapGesture { onDismiss() }
    }
}
 
#Preview {

    ZStack {
        Color.appGray.ignoresSafeArea()
        CancelActivityModal(isPresented: .constant(true))
    }
}
 
