//
//  ExploreView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 31/3/2022.
//

import SwiftUI

struct ExploreView: View {
  var body: some View {
    VStack {
      
      ScrollView {
        LazyVStack {
          ForEach(0 ..< 20) { item in
            NavigationLink(destination: Text("Some Profile View")) {
              UserRowView()
            }
          }
        }
      }
      
    }
    .navigationTitle("Explore")
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct ExploreView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ExploreView()
    }
  }
}
