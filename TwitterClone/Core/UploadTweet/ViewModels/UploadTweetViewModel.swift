//
//  UploadTweetViewModel.swift
//  TwitterClone
//
//  Created by Aybars Acar on 6/4/2022.
//

import Foundation

final class UploadTweetViewModel: ObservableObject {
  
  @Published var didUploadTweet: Bool = false
  
  let service: TweetService
  
  init() {
    self.service = TweetService()
  }
  
  func uploadTweet(withCaption caption: String) {
    service.uploadTweet(withCaption: caption) { [weak self] success in
      if success {
        // dismiss screen
        self?.didUploadTweet = true
      }
      else {
        // show error message to user
      }
    }
  }
}
