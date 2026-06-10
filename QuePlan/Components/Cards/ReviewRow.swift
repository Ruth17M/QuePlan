//
//  ReviewRow.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct ReviewRow: View {
    var userName: String = "Camila Liedo"
    var experienceName: String = "pinta tu totebag"
    var comment: String = "Fue el mejor evento al que he asistido"
    var rating: Double = 4.3
 
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AvatarView(size: 42, showBorder: false)
            VStack(alignment: .leading, spacing: 4) {
                Text(userName)
                    .font(.system(size: 14, weight: .semibold))
                Text("fue al evento \(experienceName) y dice:")
                    .font(.system(size: 12))
                    .foregroundColor(.appTextSecondary)
                Text(comment)
                    .font(.system(size: 13))
                    .foregroundColor(.appTextPrimary)
                StarRatingView(rating: rating, size: 12)
            }
        }
    }
}
 
enum ParticipantStatus { case pending, accepted, rejected }
 
struct ParticipantRow: View {
    var name: String = "Camila Liedo"
    var spots: Int = 4
    var status: ParticipantStatus = .pending
 
    var body: some View {
        HStack(spacing: 12) {
            if status == .rejected {
                Circle()
                    .fill(Color.red)
                    .frame(width: 32, height: 32)
                    .overlay(Image(systemName: "xmark").font(.system(size: 14, weight: .bold)).foregroundColor(.white))
            } else if status == .accepted {
                Circle()
                    .fill(Color.green)
                    .frame(width: 32, height: 32)
                    .overlay(Image(systemName: "checkmark").font(.system(size: 14, weight: .bold)).foregroundColor(.white))
            }
            AvatarView(size: 38, showBorder: false)
            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.system(size: 14, weight: .medium))
                Text("Lugares: \(spots) personas")
                    .font(.system(size: 12))
                    .foregroundColor(.appTextSecondary)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
 
#Preview {
    ScrollView {
        VStack(spacing: 16) {
            ExperienceCard()
            ActivityRowCard()
            ReviewRow()
            ParticipantRow(status: .rejected)
            ParticipantRow(status: .accepted)
            ParticipantRow(status: .pending)
        }
        .padding()
    }
}
 
