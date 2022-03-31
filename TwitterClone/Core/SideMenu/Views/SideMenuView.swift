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
        
        if item == .profile {
          NavigationLink {
            ProfileView()
          } label: {
            SideMenuRowView(option: item)
          }
        }
        else if item == .logout {
          SideMenuRowView(option: item)
            .onTapGesture {
              print("Logout")
            }
        }
        else {
          SideMenuRowView(option: item)
        }
        
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
