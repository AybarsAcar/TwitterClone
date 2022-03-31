//
//  SideMenuView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 31/3/2022.
//

import SwiftUI

struct SideMenuView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 32) {
      VStack(alignment: .leading) {
        
        Circle()
          .frame(width: 48, height: 49)
        
        VStack(alignment: .leading, spacing: 4) {
          Text("Bruce Wayne")
            .font(.headline.bold())
          
          Text("@batman")
            .font(.caption)
            .foregroundColor(.secondary)
        }
        
        UserStatsView()
          .padding(.vertical)
      }
      .padding(.leading)
      
      ForEach(SideMenuViewModel.allCases, id: \.self) { item in
        
        HStack(spacing: 16) {
          Image(systemName: item.imageName)
            .font(.headline)
            .foregroundColor(.secondary)
          
          Text(item.title)
            .font(.subheadline)
          
          Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal)
      }
      
      Spacer()
    }
    .background(Color.white)
  }
}

struct SideMenuView_Previews: PreviewProvider {
  static var previews: some View {
    SideMenuView()
  }
}
