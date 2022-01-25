//
//  Follows.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  func follow(from fromUserID: String, to toUserID: String) async throws -> (Bool, Bool) {
    // https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/post-users-source_user_id-following
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/following")!
        
    let headers = getBearerHeaders(type: .User)
    
    let body = ["target_user_id": toUserID]
    let bodyData = try JSONEncoder().encode(body)
    
    let (data, _) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
    
    let followingModel = try JSONDecoder().decode(FollowResponseModel.self, from: data)
    
    return (followingModel.following, followingModel.pendingFollow)
  }
  
  func unFollow(from fromUserID: String, to toUserID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/delete-users-source_id-following
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(fromUserID)/following/\(toUserID)")!
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.delete(url: url, headers: headers)
    
    let unFollowingModel = try JSONDecoder().decode(UnFollowResponseModel.self, from: data)
    
    return unFollowingModel.following
  }
  
  public func fetchFolloing(by userID: String) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/get-users-id-following
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/following")!
    
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers)
    
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }
  
  public func fetchFollower(by userID: String) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/get-users-id-followers
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/followers")!
        
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers)
    
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }
}
