//
//  ProfileViewModel.swift
//  TwitterClone
//
//  Created by Aybars Acar on 8/4/2022.
//

import Foundation

final class ProfileViewModel: ObservableObject {
  
  @Published var tweets = [Tweet]()
  
  private let tweetService: TweetService
  let user: User
  
  init(user: User) {
    self.user = user
    self.tweetService = TweetService()
    
    fetchUserTweets()
  }
  
  func fetchUserTweets() {
    
    guard let uid = user.id else { return }
    
    tweetService.fetchTweets(forUid: uid) { [weak self] tweets in
      self?.tweets = tweets
      
      for i in 0..<tweets.count {
        self?.tweets[i].user = self?.user
      }
    }
  }
}
