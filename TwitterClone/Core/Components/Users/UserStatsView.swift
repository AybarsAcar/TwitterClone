//
//  UserStatsView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 31/3/2022.
//

import SwiftUI

struct UserStatsView: View {
  var body: some View {
    HStack {
      HStack(spacing: 4) {
        Text("807")
          .font(.subheadline.bold())
        
        Text("Flowing")
          .font(.caption)
          .foregroundColor(.secondary)
      }
      
      HStack(spacing: 4) {
        Text("6.9M")
          .font(.subheadline.bold())
        
        Text("Followers")
          .font(.caption)
          .foregroundColor(.secondary)
      }
    }
  }
}

struct UserStatsView_Previews: PreviewProvider {
  static var previews: some View {
    UserStatsView()
  }
}
