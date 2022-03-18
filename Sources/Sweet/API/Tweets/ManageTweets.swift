//
//  ManageTweets.swift
//  
//
//  Created by zunda on 2022/01/17.
//

import Foundation
import HTTPClient

extension Sweet {
  public func createTweet(_ postTweetModel: PostTweetModel) async throws -> TweetModel {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/post-tweets
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets")!
    
    let headers = getBearerHeaders(type: .User)
    
    let bodyData = try JSONEncoder().encode(postTweetModel)
    
    let (data, urlResponse) = try await HTTPClient.post(url: url, body: bodyData, headers: headers)
    
    if let response = try? JSONDecoder().decode(TweetResponseModel.self, from: data) {
      return response.tweet
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
  
  public func deleteTweet(by id: String) async throws -> Bool {
    // https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/delete-tweets-id
    
    let url: URL = .init(string: "https://api.twitter.com/2/tweets/\(id)")!
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, urlResponse) = try await HTTPClient.delete(url: url, headers: headers)
    
    if let response = try? JSONDecoder().decode(DeleteResponseModel.self, from: data) {
      return response.deleted
    }
    
    if let response = try? JSONDecoder().decode(ResponseErrorModel.self, from: data) {
      throw TwitterError.invalidRequest(error: response)
    }
    
    throw TwitterError.unknwon(data: data, response: urlResponse)
  }
}

public struct PostTweetModel {
  public let text: String?
  public let directMessageDeepLink: URL?
  public let forSuperFollowersOnly: Bool
  public let geo: GeoModel?
  public let media: PostMediaModel?
  public let poll: SendPollModel?
  public let quoteTweetID: String?
  public let reply: ReplyModel?
  public let replySettings: ReplyOption?
}

extension PostTweetModel: Encodable {
  private enum CodingKeys: String, CodingKey {
    case text
    case directMessageDeepLink = "direct_message_deep_link"
    case forSuperFollowersOnly = "for_super_followers_only"
    case geo
    case media
    case poll
    case quoteTweetID = "quote_tweet_id"
    case reply
    case replySettings = "reply_settings"
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if let text = text { try container.encode(text, forKey: .text) }
    if let directMessageDeepLink = directMessageDeepLink { try container.encode(directMessageDeepLink, forKey: .directMessageDeepLink) }
    try container.encode(forSuperFollowersOnly, forKey: .forSuperFollowersOnly)
    if let geo = geo { try container.encode(geo, forKey: .geo) }
    if let media = media { try container.encode(media, forKey: .media) }
    if let poll = poll { try container.encode(poll, forKey: .poll) }
    if let quoteTweetID = quoteTweetID { try container.encode(quoteTweetID, forKey: .quoteTweetID) }
    if let reply = reply { try container.encode(reply, forKey: .reply) }
    if let replySettings = replySettings { try container.encode(replySettings.rawValue, forKey: .replySettings) }
  }
}

public enum ReplyOption: String {
  case mentionedUsers
  case following
  case everyone
}


public struct GeoModel: Codable {
  public let placeID: String
  
  private enum CodingKeys: String, CodingKey {
    case placeID = "place_id"
  }
}

public struct SendPollModel: Encodable {
  public let options: [String]
  public let durationMinutes: Int
  
  private enum CodingKeys: String, CodingKey {
    case options
    case durationMinutes = "duration_minutes"
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(options, forKey: .options)
    try container.encode(durationMinutes, forKey: .durationMinutes)
  }
}

public struct PostMediaModel: Encodable {
  public let mediaIDs: [String]
  public let taggedUserIDs: [String]
  
  private enum CodingKeys: String, CodingKey {
    case mediaIDs = "media_ids"
    case taggedUserIDs = "tagged_user_ids"
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(mediaIDs, forKey: .mediaIDs)
    try container.encode(taggedUserIDs, forKey: .taggedUserIDs)
  }
}

public struct ReplyModel: Encodable {
  public let excludeReplyUserIDs: [String]
  public let inReplyToTweetID: [String]
  
  private enum CodingKeys: String, CodingKey {
    case excludeReplyUserIDs = "exclude_replay_user_ids"
    case inReplyToTweetID = "in_reply_to_tweet_id"
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(excludeReplyUserIDs, forKey: .excludeReplyUserIDs)
    try container.encode(inReplyToTweetID, forKey: .inReplyToTweetID)
  }
}
