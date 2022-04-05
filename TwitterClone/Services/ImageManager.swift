//
//  ImageManager.swift
//  TwitterClone
//
//  Created by Aybars Acar on 5/4/2022.
//

import UIKit
import Firebase

final class ImageManager {
  static let shared = ImageManager()
  private init() { }
  
  func upload(image: UIImage, completion: @escaping (_ result: Result<String, Error>) -> Void) {
    guard let imageData = image.jpegData(compressionQuality: 0.5) else {
      completion(.failure(NSError(domain: "Cannot compress the image", code: 0)))
      return
    }
    
    let filename = NSUUID().uuidString
    let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
    
    ref.putData(imageData, metadata: nil) { _, error in
      if let error = error {
        completion(.failure(error))
        print("Failed to upload image with error: \(error)")
        return
      }
      
      ref.downloadURL { imageURL, _ in
        guard let imageURLString = imageURL?.absoluteString else {
          completion(.failure(NSError(domain: "Error returning imageURL", code: 0)))
          return
        }
        
        completion(.success(imageURLString))
      }
    }
  }
}
