//
//  User.swift
//  TwitterClone
//
//  Created by Aybars Acar on 5/4/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
  @DocumentID var id: String?
  
  let username: String
  let fullname: String
  let profileImageURL: String
  let email: String
  
  enum CodingKeys: String, CodingKey {
    case id, username, fullname, email
    case profileImageURL = "profileImageUrl"
  }
}


extension User {
  static let dummyUser = User(id: "", username: "aybarsacar", fullname: "Aybars Acar", profileImageURL: "https://firebasestorage.googleapis.com:443/v0/b/twitterclone-f2209.appspot.com/o/profile_image%2FA7EDF107-335A-472D-8301-04E7A216322E?alt=media&token=7522b6d0-d743-4c18-a62b-2ef7a172e079", email: "aybars@gmail.com")
}
