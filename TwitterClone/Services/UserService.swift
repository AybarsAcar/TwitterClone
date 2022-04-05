//
//  UserService.swift
//  TwitterClone
//
//  Created by Aybars Acar on 5/4/2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

final class UserService {
  
  func fetchUser(withUid uid: String, completion: @escaping (_ user: User) -> Void) {
    Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
      guard let snapshot = snapshot, error == nil else {
        return
      }
      
      guard let user = try? snapshot.data(as: User.self) else {
        return
      }
      
      completion(user)
    }
  }
}
