//
//  ExploreViewModel.swift
//  TwitterClone
//
//  Created by Aybars Acar on 6/4/2022.
//

import Foundation

final class ExploreViewModel: ObservableObject {
  
  @Published var users = [User]()
  @Published var searchText = ""
  
  var searchableUsers: [User] {
    if searchText.isEmpty {
      return users
    }
    else {
      let lowercasedQuery = searchText.lowercased()
      
      return users.filter({ $0.username.lowercased().contains(lowercasedQuery) || $0.fullname.lowercased().contains(lowercasedQuery) })
    }
  }
  
  private let service: UserService
  
  init() {
    self.service = UserService()
    
    fetchUsers()
  }
  
  func fetchUsers() {
    service.fetchUsers { [weak self] users in
      self?.users = users
    }
  }
}
