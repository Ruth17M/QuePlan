//
//  QuePlanApp.swift
//  QuePlan
//
//  Created by Ruth Manriquez on 04/06/26.
//

import SwiftUI

@main
struct QuePlanApp: App {
    @StateObject private var session = AppSession()

      var body: some Scene {
          WindowGroup {
              RootView()
                  .environmentObject(session)
          }
      }
}


