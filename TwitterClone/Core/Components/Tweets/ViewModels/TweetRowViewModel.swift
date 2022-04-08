//
//  TweetRowViewModel.swift
//  TwitterClone
//
//  Created by Aybars Acar on 8/4/2022.
//

import Foundation

final class TweetRowViewModel: ObservableObject {
  
  @Published var tweet: Tweet

  private let service: TweetService
  
  init(tweet: Tweet) {
    self.tweet = tweet
    self.service = TweetService()
    
    checkIfUserLikedTweet()
  }
  
  func checkIfUserLikedTweet() {
    service.checkIfUserLikedTweet(tweet) { [weak self] didLike in
      if didLike { // because already false by default
        self?.tweet.didLike = true
      }
    }
  }
  
  func likeTweet() {
    service.likeTweet(tweet) { [weak self] success in
      if success {
        self?.tweet.didLike = true
      }
    }
  }
  
  func unLikeTweet() {
    service.unLikeTweet(tweet) { [weak self] success in
      if success {
        self?.tweet.didLike = false
      }
    }
  }
}
