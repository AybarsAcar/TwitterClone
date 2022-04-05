//
//  TwitterCloneApp.swift
//  TwitterClone
//
//  Created by Aybars Acar on 31/3/2022.
//

import SwiftUI
import Firebase

@main
struct TwitterCloneApp: App {
  
  @StateObject private var authViewModel: AuthViewModel
  
  init() {
    FirebaseApp.configure()
    self._authViewModel = StateObject(wrappedValue: AuthViewModel())
  }
  
  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
      }
      .environmentObject(authViewModel)
    }
  }
}
