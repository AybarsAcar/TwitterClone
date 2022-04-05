//
//  AuthViewModel.swift
//  TwitterClone
//
//  Created by Aybars Acar on 4/4/2022.
//

import Foundation
import Firebase
import UIKit

final class AuthViewModel: ObservableObject {
  
  @Published private(set) var userSession: FirebaseAuth.User?
  @Published var didAuthenticateUser: Bool = false
  
  private var temporaryUserSession: FirebaseAuth.User?
  
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
    
    Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
      guard let authResult = authResult, error == nil else {
        if let error = error {
          print("Failed to register with error \(error)")
        }
        return
      }
      
      let user = authResult.user
      self?.temporaryUserSession = user
      
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
          self?.didAuthenticateUser = true
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
  
  func uploadProfileImage(_ image: UIImage) {
    guard let uid = temporaryUserSession?.uid else { return }
    
    ImageManager.shared.upload(image: image) { [weak self] result in
      switch result {
      case .success(let urlString):
        Firestore.firestore().collection("users")
          .document(uid)
          .updateData(["profileImageUrl": urlString]) { _ in
            self?.userSession = self?.temporaryUserSession
          }
        
      case .failure(let error):
        print(error)
      }
    }
  }
}
