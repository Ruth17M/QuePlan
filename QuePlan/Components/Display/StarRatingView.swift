//
//  StarRatingView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Double
    var size: CGFloat = 14
 
    var body: some View {
        HStack(spacing: 3) {
            ForEach(1...5, id: \.self) { i in
                Image(systemName: starName(for: i))
                    .resizable()
                    .frame(width: size, height: size)
                    .foregroundColor(.yellow)
            }
        }
    }
 
    private func starName(for index: Int) -> String {
        if Double(index) <= rating { return "star.fill" }
        if Double(index) - 0.5 <= rating { return "star.leadinghalf.filled" }
        return "star"
    }
}


struct InteractiveStarRating: View {
    @Binding var rating: Int
    var size: CGFloat = 36
 
    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...5, id: \.self) { i in
                Image(systemName: i <= rating ? "star.fill" : "star")
                    .resizable()
                    .frame(width: size, height: size)
                    .foregroundColor(i <= rating ? .yellow : Color.appGrayMid)
                    .onTapGesture { rating = i }
            }
        }
    }
}
 
struct PinkWaveHeader: View {
    var height: CGFloat = 300
    var content: AnyView = AnyView(EmptyView())
 
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.appPink
            Ellipse()
                .fill(Color.white)
                .frame(width: 700, height: 90)
                .offset(y: 45)
        }
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .overlay(content)
    }
}
 
#Preview {
    VStack(spacing: 20) {
        HStack(spacing: 12) {
            AvatarView(size: 44)
            AvatarView(size: 60)
            EditableAvatarView(size: 80)
        }
        StarRatingView(rating: 4.3)
        InteractiveStarRating(rating: .constant(3))
        PinkWaveHeader(height: 160)
    }
    .padding()
}
