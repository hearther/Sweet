//
//  TestTweetsAPI.swift
//  
//
//  Created by zunda on 2022/01/15.
//

import XCTest
@testable import Sweet

final class TestTweetsAPI: XCTestCase {
  let testMyUserID = "1048032521361866752"
  
  func testLookUpTweets() async throws {
    let tweetIDs = ["1481674458586927105", "1480571976414543875"]
    
    let sweet = Sweet.exampleSweet()
    let tweets = try await sweet.lookUpTweets(by: tweetIDs)
    
    tweets.forEach {
      print($0.text)
    }
  }
  
  func testLookUpTweet() async throws {
    let tweetID = "1481674458586927105"
    
    let sweet = Sweet.exampleSweet()
    let tweet = try await sweet.lookUpTweet(by: tweetID)
    
    print(tweet)
  }
  
  func testCreateTweet() async throws {
    let text = UUID().uuidString
    
    let sweet = Sweet.exampleSweet()
    let tweet = try await sweet.createTweet(text: text)
    
    print(tweet)
  }
  
  func testDeleteTweet() async throws {
    let tweetID = "1482357307178577923"
    
    let sweet = Sweet.exampleSweet()
    let isDeleted = try await sweet.deleteTweet(by: tweetID)
    
    print(isDeleted)
  }
  
  func testFetchTimeLine() async throws {
    let userID = "2244994945"
    let sweet = Sweet.exampleSweet()
    let tweets = try await sweet.fetchTimeLine(by: userID)
    
    tweets.forEach {
      print($0.text)
    }
  }
  
  func testFetchMentions() async throws {
    let userID = "2244994945"
    let sweet = Sweet.exampleSweet()
    let tweets = try await sweet.fetchMentions(by: userID)
    
    tweets.forEach {
      print($0.text)
    }
  }
  
  func testSearchRecentTweet() async throws {
    let query = "from%3Atwitterdev%20new%20-is%3Aretweet"
    let sweet = Sweet.exampleSweet()
    let tweets = try await sweet.searchRecentTweet(by: query)
    
    tweets.forEach {
      print($0.text)
    }
  }
  
  func testSearchTweet() async throws {
    let query = "from%3Atwitterdev%20new%20-is%3Aretweet"
    let sweet = Sweet.exampleSweet()
    let tweets = try await sweet.searchTweet(by: query)
    
    tweets.forEach {
      print($0.text)
    }
  }
  
  func testFetchRecentCountTweet() async throws {
    let query = "lakers"
    
    let sweet = Sweet.exampleSweet()
    let countTweetModels = try await sweet.fetchRecentCountTweet(by: query)
    
    countTweetModels.forEach {
      print($0.countTweet)
    }
  }
  
  func testFetchCountTweet() async throws {
    let query = "lakers"
    
    let sweet = Sweet.exampleSweet()
    let tweets = try await sweet.fetchCountTweet(by: query)
    
    tweets.forEach {
      print($0.countTweet)
    }
  }
  
  func testFetchStreamRule() async throws {
    let sweet = Sweet.exampleSweet()
    let streamRuleModels = try await sweet.fetchStreamRule()
    
    streamRuleModels.forEach {
      print($0.id, $0.value)
    }
  }
  
  func testFetchStream() async throws {
    let sweet = Sweet.exampleSweet()
    let streamRuleModels = try await sweet.fetchStream()
    
    streamRuleModels.forEach {
      print($0.value)
    }
  }
  
  func testCreateStreamRule() async throws {
    let streamModels: [StreamRuleModel] = [
      .init(value: "cat has:media", tag: "cats with media"),
    ]
    
    let sweet = Sweet.exampleSweet()
    let streamRuleModels = try await sweet.createStreamRule(streamModels)
    
    streamRuleModels.forEach {
      print($0.id, $0.value)
    }
  }
  
  func testDeleteStreamRuleByID() async throws {
    let ids = [
      "1482601916433506305",
      "1482602294482857989",
      "1482602422727966722",
    ]
    
    let sweet = Sweet.exampleSweet()
    try await sweet.deleteStreamRule(ids: ids)
  }
  
  func testDeleteStreamRuleByValue() async throws {
    let values = [
      "meme",
      "cat has:media"
    ]
    
    let sweet = Sweet.exampleSweet()
    try await sweet.deleteStreamRule(values: values)
  }
  
  func testFetchStreamVolume() async throws {
    let sweet = Sweet.exampleSweet()
    let tweets = try await sweet.fetchStreamVolume()
    
    tweets.forEach {
      print($0.text)
    }
  }
  
  func testFetchRetweetUsers() async throws {
    let tweetID = "1481674458586927105"
    
    let sweet = Sweet.exampleSweet()
    let users = try await sweet.fetchRetweetUsers(by: tweetID)
    
    users.forEach {
      print($0.username)
    }
  }
  
  func testRetweet() async throws {
    let userID = testMyUserID
    let tweetID = "1481674458586927105"
    
    let sweet = Sweet.exampleSweet()
    let retweeted = try await sweet.retweet(userID: userID, tweetID: tweetID)
    
    print(retweeted)
  }
  
  func testDeleteRetweet() async throws {
    let userID = testMyUserID
    let tweetID = "1481674458586927105"
    
    let sweet = Sweet.exampleSweet()
    let retweeted = try await sweet.deleteRetweet(userID: userID, tweetID: tweetID)
    
    print(retweeted)
  }
  
  func testFetchLikingTweetUser() async throws {
    let tweetID = "1481674458586927105"
    
    let sweet = Sweet.exampleSweet()
    let users = try await sweet.fetchLikingTweetUser(by: tweetID)
    
    users.forEach {
      print($0.username)
    }
  }
  
  func testFetchLikedTweet() async throws {
    let userID = testMyUserID
    
    let sweet = Sweet.exampleSweet()
    let tweets = try await sweet.fetchLikedTweet(by: userID)
    
    tweets.forEach {
      print($0.text)
    }
  }
  
  func testLike() async throws {
    let userID = testMyUserID
    let tweetID = "1481674458586927105"
    
    let sweet = Sweet.exampleSweet()
    let liked = try await sweet.like(userID: userID, tweetID: tweetID)
    print(liked)
  }
  
  func testUnLike() async throws {
    let userID = testMyUserID
    let tweetID = "1481674458586927105"
    
    let sweet = Sweet.exampleSweet()
    let liked = try await sweet.unLike(userID: userID, tweetID: tweetID)
    print(liked)
  }
  
  func testHideReply() async throws {
    let tweetID = "1482717178143326210"
    
    let sweet = Sweet.exampleSweet()
    let hidden = try await sweet.hideReply(tweetID: tweetID, hidden: true)
    print(hidden)
  }
}
