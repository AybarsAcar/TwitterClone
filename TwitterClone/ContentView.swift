//
//  ContentView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 31/3/2022.
//

import SwiftUI

struct ContentView: View {
  
  @State private var showSideMenu = false
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      NavigationView {
        MainTabView()
          .navigationTitle("Home")
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
      }
      
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
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ContentView()
    }
  }
}
