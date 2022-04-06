//
//  FeedView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 31/3/2022.
//

import SwiftUI

struct FeedView: View {
  
  @ObservedObject private var viewModel = FeedViewModel()
  
  @State private var showNewTweetView = false
  
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      ScrollView {
        LazyVStack {
          ForEach(viewModel.tweets) { tweet in
            TweetRowView(tweet: tweet)
            Divider()
          }
        }
      }
      
      Button {
        showNewTweetView.toggle()
      } label: {
        Image("new-tweet")
          .resizable()
          .renderingMode(.template)
          .foregroundColor(.white)
          .frame(width: 28, height: 28)
          .padding()
      }
      .background(Color.blue)
      .clipShape(Circle())
      .padding()
      .fullScreenCover(isPresented: $showNewTweetView) {
        NewTweetView()
      }
      
    }
    .navigationTitle("Home")
  }
}

struct FeedView_Previews: PreviewProvider {
  static var previews: some View {
    FeedView()
  }
}
