//
//  ProfileView.swift
//  TwitterClone
//
//  Created by Aybars Acar on 31/3/2022.
//

import SwiftUI

struct ProfileView: View {
  
  @State private var selectedFilter: TweetFilterViewModel = .tweets
  
  @Namespace private var animation
  
  var body: some View {
    VStack(alignment: .leading) {
      
      headerView
      
      actionButtons
      
      profileInfo
      
      filterBar
      
      tweetsList
            
      Spacer()
    }
  }
}

extension ProfileView {
  
  private var headerView: some View {
    ZStack(alignment: .bottomLeading) {
      Color.blue
        .ignoresSafeArea()
      
      VStack {
        
        Button {
          
        } label: {
          Image(systemName: "arrow.left")
            .resizable()
            .frame(width: 20, height: 16)
            .foregroundColor(.white)
        }
        
        
        Circle()
          .frame(width: 72, height: 72)
          .offset(x: 16, y: 24)
      }
    }
    .frame(height: 96)
  }
  
  private var actionButtons: some View {
    HStack(spacing: 12) {
      Spacer()
      
      Image(systemName: "bell.badge")
        .font(.title3)
        .padding(6)
        .overlay(
          Circle()
            .stroke(.secondary, lineWidth: 0.75)
        )
      
      Text("Edit Profile")
        .font(.subheadline.bold())
        .frame(width: 120, height: 32)
        .overlay(
          RoundedRectangle(cornerRadius: 20)
            .stroke(.secondary, lineWidth: 0.75)
        )
        .onTapGesture {
          
        }
    }
    .padding(.trailing)
  }
  
  private var profileInfo: some View {
    VStack(alignment: .leading, spacing: 4) {
      HStack {
        Text("Heath Ledger")
          .font(.title2.bold())
        
        Image(systemName: "checkmark.seal.fill")
          .foregroundColor(.blue)
      }
      
      Text("@joker")
        .font(.subheadline)
        .foregroundColor(.secondary)
      
      Text("Your mum's favourite villian")
        .font(.subheadline)
        .padding(.vertical)
      
      HStack(spacing: 24) {
        
        HStack {
          Image(systemName: "mappin.and.ellipse")
          Text("Gotham, NY")
        }
        
        HStack {
          Image(systemName: "link")
          Text("https://www.joker.com")
        }
      }
      .font(.caption)
      .foregroundColor(.secondary)
      
      HStack {
        HStack(spacing: 4) {
          Text("807")
            .font(.subheadline.bold())
          
          Text("Flowing")
            .font(.caption)
            .foregroundColor(.secondary)
        }
        
        HStack(spacing: 4) {
          Text("6.9M")
            .font(.subheadline.bold())
          
          Text("Followers")
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }
      .padding(.vertical)
    }
    .padding(.horizontal)
  }
  
  private var filterBar: some View {
    HStack(spacing: 0) {
      ForEach(TweetFilterViewModel.allCases, id: \.self) { item in
        VStack {
          Text(item.title)
            .font(.subheadline)
            .fontWeight(selectedFilter == item ? .semibold : .regular)
            .foregroundColor(selectedFilter == item ? .primary : .secondary)
            .frame(maxWidth: .infinity)
            .onTapGesture {
              withAnimation(.easeInOut) {
                selectedFilter = item
              }
            }
          
          if selectedFilter == item {
            Capsule()
              .frame(height: 3)
              .foregroundColor(.blue)
              .matchedGeometryEffect(id: "filter", in: animation)
          }
          else {
            Capsule()
              .frame(height: 3)
              .foregroundColor(.blue)
              .opacity(0)
          }
        }
      }
    }
    .overlay(
      Divider()
        .offset(y: 16)
    )
  }
  
  private var tweetsList: some View {
    ScrollView {
      LazyVStack {
        ForEach(0..<10) { item in
          TweetRowView()
        }
      }
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
