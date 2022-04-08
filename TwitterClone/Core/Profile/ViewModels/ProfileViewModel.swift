//
//  ProfileViewModel.swift
//  TwitterClone
//
//  Created by Aybars Acar on 8/4/2022.
//

import Foundation

final class ProfileViewModel: ObservableObject {
  
  @Published var tweets = [Tweet]()
  @Published var likedTweets = [Tweet]()
  
  private let tweetService: TweetService
  private let userService: UserService
  let user: User
  
  init(user: User) {
    self.user = user
    self.tweetService = TweetService()
    self.userService = UserService()
    
    fetchUserTweets()
    fetchLikedTweets()
  }
  
  var actionButtonTitle: String {
    return user.isCurrentUser ? "Edit Profile" : "Follow"
  }
  
  func tweets(forFilter filter: TweetFilterViewModel) -> [Tweet] {
    switch filter {
    case .tweets:
      return tweets
    case .replies:
      return tweets
    case .likes:
      return likedTweets
    }
  }
  
  private func fetchUserTweets() {
    
    guard let uid = user.id else { return }
    
    tweetService.fetchTweets(forUid: uid) { [weak self] tweets in
      self?.tweets = tweets
      
      for i in 0..<tweets.count {
        self?.tweets[i].user = self?.user
      }
    }
  }
  
  private func fetchLikedTweets() {
    guard let uid = user.id else { return }

    tweetService.fetchLikedTweets(forUid: uid) { [weak self] tweets in
      self?.likedTweets = tweets
      
      for i in 0..<tweets.count {
        let uid = tweets[i].uid
        
        self?.userService.fetchUser(withUid: uid) { user in
          self?.likedTweets[i].user = user
        }
      }
    }
  }
}
