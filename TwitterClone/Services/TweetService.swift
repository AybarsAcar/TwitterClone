//
//  TweetService.swift
//  TwitterClone
//
//  Created by Aybars Acar on 6/4/2022.
//

import Foundation
import Firebase

final class TweetService {
  
  func uploadTweet(withCaption caption: String, completion: @escaping (_ success: Bool) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else {
      completion(false)
      return
    }
    
    let data: [String: Any] = [
      "uid": uid,
      "caption": caption,
      "likes": 0,
      "timestamp": Timestamp(date: Date())
    ]
    
    // auto generated document
    Firestore.firestore().collection("tweets").document().setData(data) { error in
      guard error == nil else {
        completion(false)
        return
      }
      
      completion(true)
    }
  }
  
  func fetchTweets(completion: @escaping (_ tweets: [Tweet]) -> Void) {
    Firestore.firestore().collection("tweets")
      .order(by: "timestamp", descending: true) // latest tweet at the top
      .getDocuments { snapshot, error in
        guard let documents = snapshot?.documents, error == nil else {
          return
        }
        
        let tweets = documents.compactMap { document in
          try? document.data(as: Tweet.self)
        }
        
        completion(tweets)
      }
  }
  
  /// fetches the tweets for a user with a given uid
  func fetchTweets(forUid uid: String, completion: @escaping (_ tweets: [Tweet]) -> Void) {
    Firestore.firestore().collection("tweets")
      .whereField("uid", isEqualTo: uid) // get the tweets for a user with the given uid
      .getDocuments { snapshot, error in
        guard let documents = snapshot?.documents, error == nil else {
          return
        }
        
        let tweets = documents
          .compactMap { document in
            try? document.data(as: Tweet.self)
          }
          .sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
        
        completion(tweets)
      }
  }
}
