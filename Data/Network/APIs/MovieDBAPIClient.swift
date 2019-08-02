//
//  MovieDBAPIClient.swift
//  MovieDB
//
//  Created by Tim Studt on 02/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation
import Keys

extension MovieDBNetwork {
    struct APIClient: MovieDBAPI {
        var APIKey: String
        var baseURL: URL
        var allHTTPHeaderFields: [String: String] = [String: String]()
        var cachePolicy: URLRequest.CachePolicy { return URLRequest.CachePolicy.useProtocolCachePolicy }
        var timeoutInterval: TimeInterval { return 20.0 }

        init(configuration: Configuration = .default) {
            self.APIKey = configuration.APIKey
            self.baseURL = configuration.baseURL
            assert(!APIKey.isEmpty, "ERROR: API key not set")
        }
    }

    struct Configuration {
        //swiftlint:disable force_unwrapping
        static var `default`: Configuration {
            return .init(APIKey: MovieDBKeys().movieDBApiKey,
                         baseURL: URL(string: "https://api.themoviedb.org")!)
        }
        static let defaultImageURL = URL(string: "https://image.tmdb.org/t/p")! //NOTE: get from configuration API instead of hardcoding

        let APIKey: String
        let baseURL: URL

        init(APIKey: String, baseURL: URL) {
            self.APIKey = APIKey
            self.baseURL = baseURL
        }
    }
}
