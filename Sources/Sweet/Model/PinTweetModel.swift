//
//  PinTweetModel.swift
//  
//
//  Created by zunda on 2022/02/08.
//

import Foundation

public struct PinTweetModel {
  public let id: String
  public let text: String
}

extension PinTweetModel: Decodable {
  
}
