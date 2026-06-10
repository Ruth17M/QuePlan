//
//  TermsView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//
 import SwiftUI

struct TermsView: View {
    @Environment(\.dismiss) var dismiss
 
    var body: some View {
        VStack(spacing: 0) {
            // Header rosa
            PinkWaveHeader(height: 130)
 
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 14) {
                    Text("Terminos y condiciones")
                        .font(.system(size: 22, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding(.top, 24)
 
                    Group {
                        TermsSection(
                            title: "1. Aceptación de los Términos",
                            content: "Al descargar, acceder o utilizar la aplicación [Nombre de la App] (\"la App\"), usted (\"el Usuario\") acepta cumplir con estos Términos y Condiciones, así como con nuestra Política de Privacidad. Si no está de acuerdo, no debe utilizar la App."
                        )
                        TermsSection(
                            title: "2. Licencia de Uso",
                            content: "[Nombre de la Empresa] otorga al usuario una licencia limitada, no exclusiva, intransferible y revocable para descargar, instalar y utilizar la App para uso personal y no comercial."
                        )
                        TermsSection(
                            title: "3. Conducta del Usuario y Restricciones",
                            content: "El Usuario se compromete a no utilizar la App con fines ilegales, copiar o modificar la App, enviar virus, spam o contenido malicioso, ni suplantar la identidad de otra persona o empresa."
                        )
                        TermsSection(
                            title: "4. Propiedad Intelectual",
                            content: "Todo el contenido de la App, incluyendo textos, gráficos, logotipos, iconos y software, es propiedad exclusiva de [Nombre de la Empresa] y está protegido por las leyes de propiedad intelectual."
                        )
                        TermsSection(
                            title: "5. Cuentas de Usuario",
                            content: "El usuario es responsable de mantener la confidencialidad de sus credenciales (nombre de usuario y contraseña) y de todas las actividades que ocurran bajo su cuenta."
                        )
                        TermsSection(
                            title: "6. Pagos y Suscripciones (Si aplica)",
                            content: "La App puede ofrecer servicios de pago. Los precios y condiciones se detallarán antes de la compra. [Nombre de la App] no se hace responsable de errores en las transacciones."
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
        .ignoresSafeArea(edges: .top)
        .overlay(
            Button { dismiss() } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 26))
                    .foregroundColor(.white)
            }
            .padding(.top, 12)
            .padding(.trailing, 16),
            alignment: .topTrailing
        )
    }
}
 

 
#Preview { TermsView() }
