//
//  FeedView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 31/3/2022.
//

import SwiftUI

struct FeedView: View {
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(0 ..< 20) { item in
          TweetRowView()
          Divider()
        }
      }
    }
  }
}

struct FeedView_Previews: PreviewProvider {
  static var previews: some View {
    FeedView()
  }
}
