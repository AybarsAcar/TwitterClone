//
//  LoginView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 1/4/2022.
//

import SwiftUI

struct LoginView: View {
  
  @State private var email = ""
  @State private var password = ""
  
  var body: some View {
    VStack {
      
      AuthenticationHeaderView(title: "Hello.", subtitle: "WelcomeBack")

      textFields
      
      forgotPasswordButton
      
      signInButton
    
      Spacer()
      
      NavigationLink {
        RegistrationView()
          .navigationBarHidden(true)
      } label: {
        HStack {
          Text("Don't have an account?")
            .font(.footnote)
          
          Text("Sign up")
            .font(.footnote)
            .fontWeight(.semibold)
        }
        .foregroundColor(.blue)
      }
      .padding(32)

    }
    .ignoresSafeArea()
    .navigationBarHidden(true)
  }
}

extension LoginView {

  private var textFields: some View {
    
    VStack(spacing: 40) {
      TwitterTextField("Email", text: $email, withIcon: "envelope")
      
      TwitterTextField("Password", text: $password, withIcon: "lock")

    }
    .padding(.horizontal, 32)
    .padding(.top, 44)
  }
  
  private var forgotPasswordButton: some View {
    
    HStack {
      Spacer()
      
      NavigationLink {
        Text("Reset password view")
      } label: {
        Text("Forgot Password?")
          .font(.caption)
          .fontWeight(.semibold)
          .foregroundColor(.blue)
      }
    }
    .padding(.top)
    .padding(.trailing, 24)
  }
  
  private var signInButton: some View {
    Button {
      
    } label: {
      Text("Sign in")
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
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
