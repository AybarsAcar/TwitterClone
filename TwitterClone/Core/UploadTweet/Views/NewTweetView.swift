//
//  NewTweetView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 1/4/2022.
//

import SwiftUI

struct NewTweetView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  @EnvironmentObject private var authVM: AuthViewModel
  
  @ObservedObject private var viewModel = UploadTweetViewModel()
  
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
          guard !caption.isEmpty else { return }
          viewModel.uploadTweet(withCaption: caption)
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
        
        if let user = authVM.currentUser {
          Circle()
            .frame(width: 64, height: 64)
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
        }
        
        TextArea("What's happening?", text: $caption)
      }
      .padding()
    }
    .onReceive(viewModel.$didUploadTweet) { didUploadTweetSuccessfully in
      if didUploadTweetSuccessfully {
        dismiss()
      }
    }
  }
}

struct NewTweetView_Previews: PreviewProvider {
  static var previews: some View {
    NewTweetView()
  }
}
