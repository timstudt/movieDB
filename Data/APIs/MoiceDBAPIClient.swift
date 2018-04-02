//
//  MoiceDBAPIClient.swift
//  MovieDB
//
//  Created by Tim Studt on 02/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

extension MovieDBNetwork {
    struct APIClient: MovieDBAPI {
        var APIKey: String
        var baseURL: URL
        var allHTTPHeaderFields: [String: String] = [String: String]()
        var cachePolicy: URLRequest.CachePolicy { return URLRequest.CachePolicy.useProtocolCachePolicy }
        var timeoutInterval: TimeInterval { return 20.0 }
        
        init(configuration: Configuration = MovieDBNetwork.Configuration()) {
            self.APIKey = configuration.APIKey
            self.baseURL = configuration.baseURL
        }
    }
    
    struct Configuration {
        static let defaultAPIKey = "12345"
        static let defaultBaseURL = URL(string: "https://api.themoviedb.org")!
        
        var APIKey: String
        var baseURL: URL
        
        init(APIKey: String = defaultAPIKey, baseURL: URL = defaultBaseURL) {
            self.APIKey = APIKey
            self.baseURL = baseURL
        }
    }
}
