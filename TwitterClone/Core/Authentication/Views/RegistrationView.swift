//
//  RegistrationView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 1/4/2022.
//

import SwiftUI

struct RegistrationView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  @State private var email = ""
  @State private var password = ""
  @State private var username = ""
  @State private var fullName = ""
  
  var body: some View {
    VStack {
      AuthenticationHeaderView(title: "Get started.", subtitle: "Create your account")
      
      textFields
      
      signUpButton
      
      Spacer()
      
      goBackToLoginButton
    }
    .ignoresSafeArea()
  }
}

extension RegistrationView {
  
  private var textFields: some View {
    
    VStack(spacing: 40) {
      TwitterTextField("Email", text: $email, withIcon: "envelope")
      TwitterTextField("Username", text: $username, withIcon: "person")
      TwitterTextField("Full name", text: $fullName, withIcon: "person")
      TwitterTextField("Password", text: $password, withIcon: "lock")
      
    }
    .padding(.horizontal, 32)
    .padding(.top, 44)
  }
  
  private var signUpButton: some View {
    Button {
      
    } label: {
      Text("Sign up")
        .font(.headline)
        .foregroundColor(.white)
        .frame(height: 55)
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .clipShape(Capsule())
    }
    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
    .padding()
    
  }
  
  private var goBackToLoginButton: some View {
    Button {
      dismiss()
    } label: {
      HStack{
        Text("Already have an account?")
          .font(.footnote)
        
        Text("Sign in")
          .font(.footnote)
          .fontWeight(.semibold)
      }
      .padding(32)
    }

  }
}

struct RegistrationView_Previews: PreviewProvider {
  static var previews: some View {
    RegistrationView()
  }
}
