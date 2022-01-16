//
//  Retweets.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation

extension Sweet {
  func fetchRetweetUsers(by tweetID: String) async throws -> [UserModel] {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/get-tweets-id-retweeted_by
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(tweetID)/retweeted_by")!
    
    let httpMethod: HTTPMethod = .GET
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
            
    let (data, _) = try await HTTPClient.get(url: url, headers: headers)
            
    let usersResponseModel = try JSONDecoder().decode(UsersResponseModel.self, from: data)
    
    return usersResponseModel.users
  }
  
  func retweet(userID: String, tweetID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/post-users-id-retweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/retweets")!
    
    let body = ["tweet_id": tweetID]
    let bodyData = try JSONEncoder().encode(body)
    
    let httpMethod: HTTPMethod = .POST
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
            
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, body: bodyData, headers: headers)
    
    let retweetResponseModel  = try JSONDecoder().decode(RetweetResponseModel.self, from: data)
    
    return retweetResponseModel.retweeted
  }
  
  func deleteRetweet(userID: String, tweetID: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/delete-users-id-retweets-tweet_id
    
    let url: URL = .init(string: "https://api.twitter.com/2/users/\(userID)/retweets/\(tweetID)")!
    
    let httpMethod: HTTPMethod = .DELETE
    
    let headers = try getOauthHeaders(method: httpMethod, url: url.absoluteString)
            
    let (data, _) = try await HTTPClient.request(method: httpMethod, url: url, headers: headers)
    
    let retweetResponseModel  = try JSONDecoder().decode(RetweetResponseModel.self, from: data)
    
    return retweetResponseModel.retweeted
  }
}
