//
//  SideMenuRowView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 31/3/2022.
//

import SwiftUI

struct SideMenuRowView: View {
  
  let option: SideMenuViewModel
  
  var body: some View {
    HStack(spacing: 16) {
      Image(systemName: option.imageName)
        .font(.headline)
        .foregroundColor(.secondary)
      
      Text(option.title)
        .foregroundColor(.primary)
        .font(.subheadline)
      
      Spacer()
    }
    .frame(height: 40)
    .padding(.horizontal)
  }
}

struct SideMenuRowView_Previews: PreviewProvider {
  static var previews: some View {
    SideMenuRowView(option: .profile)
  }
}
