//
//  FilterdStream.swift
//  
//
//  Created by zunda on 2022/01/16.
//

import Foundation
import HTTPClient

extension Sweet {
  func searchSpaces(query: String) async throws -> [SpaceModel] {
    // https://developer.twitter.com/en/docs/twitter-api/spaces/search/api-reference/get-spaces-search

    let url: URL = .init(string: "https://api.twitter.com/2/spaces/search")!
    
    let queries = ["query": query]
    
    let headers = getBearerHeaders(type: .User)
    
    let (data, _) = try await HTTPClient.get(url: url, headers: headers, queries: queries)
        
    let spacesResponseModel = try JSONDecoder().decode(SpacesResponseModel.self, from: data)
    
    return spacesResponseModel.spaces
  }
}
