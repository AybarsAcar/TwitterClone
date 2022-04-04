//
//  AuthenticationHeaderView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 1/4/2022.
//

import SwiftUI

struct AuthenticationHeaderView: View {
  
  let title: String
  let subtitle: String
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(title)
        .font(.largeTitle)
        .fontWeight(.semibold)
      
      Text(subtitle)
        .font(.largeTitle)
        .fontWeight(.semibold)
    }
    .frame(height: 260)
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.leading)
    .background(Color.blue)
    .foregroundColor(.white)
    .roundedCorners([.bottomRight], withSize: 80)
  }
}

struct AuthenticationHeaderView_Previews: PreviewProvider {
  static var previews: some View {
    AuthenticationHeaderView(title: "Hello.", subtitle: "WelcomeBack")
  }
}
