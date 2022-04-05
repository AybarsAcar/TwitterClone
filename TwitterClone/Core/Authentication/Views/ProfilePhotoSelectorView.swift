//
//  ProfilePhotoSelectorView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 4/4/2022.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
  
  @EnvironmentObject private var authVM: AuthViewModel
  
  @State private var showImagePicker = false
  @State private var image: UIImage?
  
  var body: some View {
    VStack {
      AuthenticationHeaderView(title: "Setup account.", subtitle: "Add a profile photo")
      
      Button {
        showImagePicker.toggle()
      } label: {
        if let image = image {
          Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: 180, height: 180)
            .clipShape(Circle())
        }
        else {
          Label("Add Photo", systemImage: "photo")
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .clipShape(Capsule())
        }
      }
      .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
      .padding()
      .padding(.top, 44)
      .sheet(isPresented: $showImagePicker) {
        ImagePicker(image: $image)
      }
      
      if let image = image {
        Button {
          authVM.uploadProfileImage(image)
        } label: {
          Text("Continue")
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .clipShape(Capsule())
        }
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
        .padding()
        .padding(.top, 44)
      }
      
      Spacer()
    }
    .ignoresSafeArea()
  }
}

struct PhotoSelectorView_Previews: PreviewProvider {
  static var previews: some View {
    ProfilePhotoSelectorView()
      .environmentObject(AuthViewModel())
  }
}

  


