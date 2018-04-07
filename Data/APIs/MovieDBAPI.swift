//
//  MovieDBAPI.swift
//  MovieDB
//
//  Created by Tim Studt on 31/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

protocol MovieDBAPI: API { }

extension MovieDBAPI {

    // MARK: - endpoints
    var endpointVersion: String { return "3" }
    var movieEndpoint: String { return "movie" }
    var searchEndpoint: String { return "search" }
    var searchMoviePath: String { return "/\(endpointVersion)/\(searchEndpoint)/movie" }
    // MARK: - query items
    var APIKeyQuery: URLQueryItem { return URLQueryItem(name: "api_key", value: APIKey) }

    var defaultURLBuilder: URLBuilder {
        let builder = URLBuilder(baseURL: baseURL)
        builder
            .add(path: endpointVersion)
            .defaultQueryItems = [APIKeyQuery]
        return builder
    }
    
    // MARK: - requests
    // swiftlint:disable identifier_name
    func getMovie(id: Int) -> URLRequest {
        let builder = defaultURLBuilder
            .add(path: movieEndpoint)
            .add(path: "\(id)")
        return buildRequest(url: builder.build()!)
    }

    func searchMovie(query: String) -> URLRequest {
        let builder = defaultURLBuilder
            .add(path: searchEndpoint)
            .add(path: movieEndpoint)
            .add(query: URLQueryItem(name: "query", value: query))
        return buildRequest(url: builder.build()!)
    }
}
