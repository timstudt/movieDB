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
            assert(!self.APIKey.isEmpty, "APIClient - Error: please use a valid API key")
        }
    }

    struct Configuration {
        static let defaultAPIKey = ""
        static let defaultBaseURL = URL(string: "https://api.themoviedb.org")!
        static let defaultImageURL = URL(string: "https://image.tmdb.org/t/p")! //NOTE: get from configuration API instead of hardcoding

        var APIKey: String
        var baseURL: URL

        init(APIKey: String = defaultAPIKey, baseURL: URL = defaultBaseURL) {
            self.APIKey = APIKey
            self.baseURL = baseURL
        }
    }
}
