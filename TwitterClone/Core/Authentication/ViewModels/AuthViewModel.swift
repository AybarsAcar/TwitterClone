//
//  AuthViewModel.swift
//  TwitterClone
//
//  Created by Aybars Acar on 4/4/2022.
//

import Foundation
import Firebase
import UIKit
import Combine

final class AuthViewModel: ObservableObject {
  
  @Published private(set) var userSession: FirebaseAuth.User?
  @Published var didAuthenticateUser: Bool = false
  
  // our user object that we fetch
  @Published var currentUser: User?
  
  private var temporaryUserSession: FirebaseAuth.User?
  private let userService: UserService
  
  init() {
    self.userSession = Auth.auth().currentUser
    self.userService = UserService()
    
    fetchUser()
  }
  
  func login(withEmail email: String, password: String) {
    
    Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
      guard let authResult = authResult, error == nil else {
        if let error = error {
          print("Failed to sign in with error \(error)")
        }
        return
      }
      
      let user = authResult.user
      self?.userSession = user
      self?.fetchUser()
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
            self?.fetchUser()
          }
        
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func fetchUser() {
    guard let uid = userSession?.uid else { return }
    userService.fetchUser(withUid: uid) { [weak self] user in
      self?.currentUser = user
    }
  }
}
