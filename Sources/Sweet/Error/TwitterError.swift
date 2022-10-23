//
//  TwitterError.swift
//
//
//  Created by zunda on 2022/03/14.
//

import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

extension Sweet {
  /// Twitter Error
  public enum TwitterError: Error, Sendable {
    case invalidRequest(error: Sweet.ResponseErrorModel)
    case unknown(request: URLRequest, data: Data, response: URLResponse)
    case followError
    case listError
    case hiddenError
    case likeError
    case deleteError
    case retweetError
    case blockError
    case muteError
    case bookmarkError
    case uploadCompliance
  }
}
