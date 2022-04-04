//
//  RoundedShape.swift
//  TwitterClone
//
//  Created by Aybars Acar on 1/4/2022.
//

import SwiftUI

struct RoundedShape: Shape {
  
  var corners: UIRectCorner
  var size: CGFloat
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: size, height: size))
    
    return Path(path.cgPath)
  }
}

extension View {
  
  /// Clips the background Shape with a given rounded corner and a default size of 80
  /// ```
  /// .roundedCorners([.bottomLeft], withSize: 40)
  /// ```
  func roundedCorners(_ corners: UIRectCorner, withSize size: CGFloat = 80) -> some View {
    clipShape(RoundedShape(corners: corners, size: size))
  }
}
