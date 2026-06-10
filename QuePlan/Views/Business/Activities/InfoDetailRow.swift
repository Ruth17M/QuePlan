//
//  InfoDetailRow.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct InfoDetailRow: View {
    let icon: String
    let text: String
 
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(.appPink).font(.system(size: 17)).frame(width: 20)
            Text(text)
                .font(.system(size: 14)).foregroundColor(.appTextSecondary)
        }
    }
}
