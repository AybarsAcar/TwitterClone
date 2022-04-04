//
//  AuthViewModel.swift
//  TwitterClone
//
//  Created by Aybars Acar on 4/4/2022.
//

import Foundation
import Firebase

final class AuthViewModel: ObservableObject {
  
  @Published private(set) var userSession: FirebaseAuth.User?
  
  init() {
    self.userSession = Auth.auth().currentUser
  }
  
  func login(withEmail email: String, password: String) {
    
    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
      guard let authResult = authResult, error == nil else {
        if let error = error {
          print("Failed to sign in with error \(error)")
        }
        return
      }
      
      let user = authResult.user
      self.userSession = user
    }
  }
  
  func register(withEmail email: String, password: String, fullName: String, username: String) {
    
    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
      guard let authResult = authResult, error == nil else {
        if let error = error {
          print("Failed to register with error \(error)")
        }
        return
      }
      
      let user = authResult.user
      self.userSession = user
      
      let data = [
        "email": email,
        "username": username.lowercased(),
        "fullname": fullName,
        "uid": user.uid
      ]
      
      Firestore.firestore().collection("users")
        .document(user.uid)
        .setData(data) { error in
          guard error == nil else {
            print("error uploading user data")
            return
          }
          print("uploaded user data")
        }
    }
  }
  
  func signOut() {
    userSession = nil
    
    do {
      try Auth.auth().signOut()
    } catch {
      print("error signing the user out")
    }
  }
}
