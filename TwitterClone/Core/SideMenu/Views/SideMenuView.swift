//
//  SideMenuView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 31/3/2022.
//

import SwiftUI

struct SideMenuView: View {
  @EnvironmentObject private var authVM: AuthViewModel
  
  var body: some View {
    
    if let user = authVM.currentUser {
      VStack(alignment: .leading, spacing: 32) {
        VStack(alignment: .leading) {
          
          AsyncImage(url: URL(string: user.profileImageURL)) { image in
            image
              .resizable()
              .scaledToFill()
              .frame(width: 48, height: 48)
              .clipShape(Circle())
          } placeholder: {
            ProgressView()
              .frame(width: 48, height: 49)
          }
      
          
          VStack(alignment: .leading, spacing: 4) {
            Text(user.fullname)
              .font(.headline.bold())
            
            Text("@\(user.username)")
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
              ProfileView(user: user)
            } label: {
              SideMenuRowView(option: item)
            }
          }
          else if item == .logout {
            SideMenuRowView(option: item)
              .onTapGesture {
                authVM.signOut()
              }
          }
          else {
            SideMenuRowView(option: item)
          }
          
        }
        
        Spacer()
      }
      .background(Color(uiColor: UIColor.tertiarySystemBackground))
    }
  }
}

struct SideMenuView_Previews: PreviewProvider {
  static var previews: some View {
    SideMenuView()
      .environmentObject(AuthViewModel())
  }
}
