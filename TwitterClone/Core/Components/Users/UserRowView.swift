//
//  UserRowView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 31/3/2022.
//

import SwiftUI

struct UserRowView: View {
  var body: some View {
    HStack(spacing: 12) {
      Circle()
        .frame(width: 48, height: 48)
        .foregroundColor(.primary)
      
      VStack(alignment: .leading, spacing: 4) {
        Text("joker")
          .foregroundColor(.primary)
          .font(.subheadline.bold())
        
        Text("Heath Ledger")
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
    UserRowView()
  }
}
