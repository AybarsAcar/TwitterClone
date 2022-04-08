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
  
  func checkIfUserLikedTweet(_ tweet: Tweet, completion: @escaping (_ didLike: Bool) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid,
          let tweetID = tweet.id else {
      completion(false)
      return
    }
    
    Firestore.firestore().collection("users")
      .document(uid)
      .collection("user-likes")
      .document(tweetID)
      .getDocument { snapshot, error in
        guard let snapshot = snapshot, error == nil else {
          completion(false)
          return
        }
        
        completion(snapshot.exists)
      }
  }
}

// MARK: - Likes
extension TweetService {
  
  /// liked tweet IDs will be stored in the logged in user as a sub-collection
  /// update the like count on the tweet
  func likeTweet(_ tweet: Tweet, completion: @escaping (_ success: Bool) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid,
          let tweetID = tweet.id else {
      completion(false)
      return
    }
    
    // create new ref if it doesnt exist
    let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
    
    // increase the like count
    let likeCountData = ["likes": tweet.likes + 1]
    Firestore.firestore().collection("tweets").document(tweetID).updateData(likeCountData) { error in
      guard error == nil else {
        completion(false)
        return
      }
      
      // update the current users liked tweets collection
      userLikesRef.document(tweetID).setData([:]) { error in
        guard error == nil else { return }
        
        completion(true)
      }
    }
  }
  
  func unLikeTweet(_ tweet: Tweet, completion: @escaping (_ success: Bool) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid,
          let tweetID = tweet.id,
          tweet.likes > 0 else {
      completion(false)
      return
    }
    
    // we will delete the document from the user ref
    let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
    
    // decrease the like count
    let likeCountData = ["likes": tweet.likes - 1]
    Firestore.firestore().collection("tweets").document(tweetID).updateData(likeCountData) { error in
      guard error == nil else {
        completion(false)
        return
      }
      
      // delete the document from the user's likes collection
      userLikesRef.document(tweetID).delete { error in
        guard error == nil else {
          completion(false)
          return
        }
        
        completion(true)
      }
    }
  }
  
  /// grab the tweet ids from the user collection
  /// then grab the tweets with the given tweetIDs
  func fetchLikedTweets(forUid uid: String, completion: @escaping (_ tweets: [Tweet]) -> Void) {
    
    var tweets = [Tweet]()
    
    Firestore.firestore().collection("users").document(uid).collection("user-likes").getDocuments { snapshot, error in
      guard let documents = snapshot?.documents, error == nil else {
        return
      }
      
      documents.forEach { document in
        let tweetID = document.documentID
        
        // fetch the tweet
        Firestore.firestore().collection("tweets").document(tweetID).getDocument { snapshot, error in
          guard let tweet = try? snapshot?.data(as: Tweet.self), error == nil else {
            return
          }
          
          tweets.append(tweet)
          completion(tweets)
        }
      }
    }
  }
}
