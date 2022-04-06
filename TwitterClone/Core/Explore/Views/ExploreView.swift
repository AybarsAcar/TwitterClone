//
//  ExploreView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 31/3/2022.
//

import SwiftUI

struct ExploreView: View {
  
  @ObservedObject private var exploreVM = ExploreViewModel()
  
  var body: some View {
    VStack {
      
      SearchBar("Search...", text: $exploreVM.searchText)
        .padding()
      
      ScrollView {
        LazyVStack {
          ForEach(exploreVM.searchableUsers) { user in
            NavigationLink(destination: ProfileView(user: user)) {
              UserRowView(user: user)
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
