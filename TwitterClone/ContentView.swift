//
//  ContentView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 31/3/2022.
//

import SwiftUI

struct ContentView: View {
  
  @EnvironmentObject private var viewModel: AuthViewModel
  
  @State private var showSideMenu = false
  
  var body: some View {
    Group {
      if viewModel.userSession == nil {
        LoginView()
      }
      else {
        mainView
      }
    }
  }
}

// MARK: - Components
extension ContentView {
  
  private var mainView: some View {
    ZStack(alignment: .topLeading) {
      
      MainTabView()
      
      if showSideMenu {
        Color.black
          .opacity(showSideMenu ? 0.3 : 0)
          .ignoresSafeArea()
          .onTapGesture {
            withAnimation(.easeInOut) {
              showSideMenu = false
            }
          }
      }
      
      SideMenuView()
        .frame(width: 300)
        .offset(x: showSideMenu ? 0 : -300)
    }
    .navigationTitle("Home")
    .navigationBarHidden(showSideMenu)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Circle()
          .frame(width: 32, height: 32)
          .onTapGesture {
            withAnimation(.easeInOut) {
              showSideMenu.toggle()
            }
          }
      }
    }
    .onAppear {
      showSideMenu = false
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ContentView()
        .environmentObject(AuthViewModel())
    }
  }
}
