//
//  Tweet.swift
//  TwitterClone
//
//  Created by Aybars Acar on 6/4/2022.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Tweet: Identifiable, Codable {
  @DocumentID var id: String?
  
  let caption: String
  let timestamp: Timestamp
  let uid: String
  var likes: Int
  
  var user: User?
  var didLike: Bool? = false
}


extension Tweet {
  static let dummyTweet = Tweet(caption: "This is a caption", timestamp: Timestamp(date: Date()), uid: "12342", likes: 9)
}
