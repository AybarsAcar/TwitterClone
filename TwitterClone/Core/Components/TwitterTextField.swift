//
//  TwitterTextField.swift
//  TwitterClone
//
//  Created by Aybars Acar on 1/4/2022.
//

import SwiftUI

struct TwitterTextField: View {
  
  let icon: String
  let placeholder: String
  @Binding var text: String
  
  init(_ placeholder: String, text: Binding<String>, withIcon icon: String) {
    self.placeholder = placeholder
    self._text = text
    self.icon = icon
  }
  
  var body: some View {
    VStack {
      HStack {
        Image(systemName: icon)
          .resizable()
          .scaledToFit()
          .frame(width: 20, height: 20)
          .foregroundColor(Color(.darkGray))
        
        TextField(placeholder, text: $text)
      }
      
      Divider()
        .background(Color(.darkGray))
    }
  }
}

struct TwitterTextField_Previews: PreviewProvider {
  static var previews: some View {
    TwitterTextField("Email", text: .constant(""), withIcon: "envelope")
  }
}
