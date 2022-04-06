//
//  UserRowView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 31/3/2022.
//

import SwiftUI

struct UserRowView: View {
  
  let user: User
  
  var body: some View {
    HStack(spacing: 12) {
      
      Circle()
        .frame(width: 56, height: 56)
        .overlay {
          AsyncImage(url: URL(string: user.profileImageURL)) { image in
            image
              .resizable()
              .scaledToFill()
              .clipShape(Circle())
          } placeholder: {
            ProgressView()
          }
        }
      
      VStack(alignment: .leading, spacing: 4) {
        Text("@\(user.username)")
          .foregroundColor(.primary)
          .font(.subheadline.bold())
        
        Text(user.fullname)
          .font(.subheadline)
          .foregroundColor(.secondary)
      }
    }
    .padding(.horizontal)
    .padding(.vertical, 4)
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct UserRowView_Previews: PreviewProvider {
  static var previews: some View {
    UserRowView(user: User.dummyUser)
  }
}
