//
//  NewTweetView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 1/4/2022.
//

import SwiftUI

struct NewTweetView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  @State private var caption = ""
  
  var body: some View {
    VStack {
      HStack {
        Button {
          dismiss()
        } label: {
          Text("Cancel")
            .foregroundColor(.blue)
        }

        Spacer()
        
        Button {
          
        } label: {
          Text("Tweet")
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.blue)
            .clipShape(Capsule())
        }
      }
      .padding()
      
      HStack(alignment: .top) {
        Circle()
          .frame(width: 64, height: 64)
        
        TextArea("What's happening?", text: $caption)
      }
      .padding()
    }
  }
}

struct NewTweetView_Previews: PreviewProvider {
  static var previews: some View {
    NewTweetView()
  }
}
