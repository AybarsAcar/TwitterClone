//
//  FeedViewModel.swift
//  TwitterClone
//
//  Created by Aybars Acar on 6/4/2022.
//

import Foundation

final class FeedViewModel: ObservableObject {
  
  @Published var tweets = [Tweet]()
  
  let tweetService: TweetService
  let userService: UserService
  
  init() {
    self.tweetService = TweetService()
    self.userService = UserService()
    
    fetchTweets()
  }
  
  func fetchTweets() {
    tweetService.fetchTweets { [weak self] tweets in
      self?.tweets = tweets
      
      for i in 0..<tweets.count {
        let uid = tweets[i].uid
        
        self?.userService.fetchUser(withUid: uid) { user in
          self?.tweets[i].user = user
        }
      }
    }
  }
}
