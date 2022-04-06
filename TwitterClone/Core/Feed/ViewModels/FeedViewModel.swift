//
//  FeedViewModel.swift
//  TwitterClone
//
//  Created by Aybars Acar on 6/4/2022.
//

import Foundation

final class FeedViewModel: ObservableObject {
  
  @Published var tweets = [Tweet]()
  
  let service: TweetService
  
  init() {
    self.service = TweetService()
    
    fetchTweets()
  }
  
  func fetchTweets() {
    service.fetchTweets { [weak self] tweets in
      self?.tweets = tweets
    }
  }
}
