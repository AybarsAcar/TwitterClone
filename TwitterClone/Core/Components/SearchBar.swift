//
//  SearchBar.swift
//  TwitterClone
//
//  Created by Aybars Acar on 6/4/2022.
//

import SwiftUI

struct SearchBar: View {
  
  let placeholder: String
  @Binding var text: String
  
  init(_ placeholder: String, text: Binding<String>) {
    self.placeholder = placeholder
    self._text = text
  }
  
  var body: some View {
    HStack {
      TextField(placeholder, text: $text)
        .padding(8)
        .padding(.horizontal, 24)
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(8)
        .overlay(
          HStack {
            Image(systemName: "magnifyingglass")
              .foregroundColor(.gray)
              .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
              .padding(.leading, 8)
          }
        )
    }
    .padding(.horizontal, 4)
  }
}

struct SearchBar_Previews: PreviewProvider {
  static var previews: some View {
    SearchBar("Search...", text: .constant(""))
      .previewLayout(.sizeThatFits)
  }
}
