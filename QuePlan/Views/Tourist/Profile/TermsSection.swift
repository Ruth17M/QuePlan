//
//  TermsSection.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct TermsSection: View {

    let title: String
    let content: String   // ✅ FIX: renombrado de 'body' a 'content'
                          //    'body' colisiona con var body: some View del protocolo View

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.appTextPrimary)
            Text(content)  // ✅ usa 'content'
                .font(.system(size: 13))
                .foregroundColor(.appTextSecondary)
                .lineSpacing(3)
        }
    }
}

#Preview {
    TermsSection(
        title: "1. Aceptación de los Términos",
        content: "Al descargar, acceder o utilizar la aplicación, usted acepta cumplir con estos Términos y Condiciones."
    )
    .padding()
}
