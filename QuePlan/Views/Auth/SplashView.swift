//
//  SplashView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 05/06/26.
//

import SwiftUI

struct SplashView: View {
    @State private var isReady = false
 
    var body: some View {
        if isReady {
            WelcomeView()
        } else {
            ZStack {
                Color.appPink.ignoresSafeArea()
                VStack(spacing: 20) {
                    Image(systemName: "x.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
 
                    Text("Tu mejor aventura\na un click")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
 
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.3)
                        .padding(.top, 8)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation { isReady = true }
                }
            }
        }
    }
}
