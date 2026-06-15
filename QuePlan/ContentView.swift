//
//  ContentView.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 04/06/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RootView()
       // SplashView()
      // TouristTabView()
   // BusinessTabView()
    }
}

struct RootView: View {
    @EnvironmentObject var session: AppSession

    var body: some View {
        switch session.destino {
        case .splash:
            SplashView()
        case .welcome:
            WelcomeView()
        case .businessHome:
            BusinessTabView()
        case .touristHome:
            TouristTabView()
        }
    }
}


#Preview {
    SplashView()
}
