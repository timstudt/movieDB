//
//  MovieDBAPI.swift
//  MovieDB
//
//  Created by Tim Studt on 31/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

protocol MovieDBAPI: API { }

//swiftlint:disable identifier_name
//swiftlint:disable force_unwrapping

extension MovieDBAPI {

    // MARK: - endpoints
    var endpointVersion: String { return "3" }
    var movieEndpoint: String { return "movie" } //TODO: make endpoint enum
    var searchEndpoint: String { return "search" }
    var configurationEndpoint: String { return "configuration" }

    var defaultURLBuilder: URLBuilder {
        let builder = URLBuilder(baseURL: baseURL)
        builder
            .add(path: endpointVersion)
            .defaultQueryItems = [APIKeyQuery()]
        return builder
    }

    // MARK: - query items
    func APIKeyQuery() -> URLQueryItem { return URLQueryItem(name: "api_key", value: APIKey) }
    func queryQuery(_ value: String) -> URLQueryItem { return URLQueryItem(name: "query", value: value) }

    // MARK: - requests
    func getMovie(id: Int) -> URLRequest {
        let urlBuilder = defaultURLBuilder
            .add(path: movieEndpoint)
            .add(path: "\(id)")
        return buildRequest(url: urlBuilder.build()!)
    }

    func searchMovie(query: String) -> URLRequest {
        let urlBuilder = defaultURLBuilder
            .add(path: searchEndpoint)
            .add(path: movieEndpoint)
            .add(query: queryQuery(query))
        return buildRequest(url: urlBuilder.build()!)
    }

    func getImage(path: String, size: String = "w300") -> URLRequest {
        let urlBuilder = URLBuilder(baseURL: MovieDBNetwork.Configuration.defaultImageURL)
            .add(path: size)
            .add(path: path)
        return buildRequest(url: urlBuilder.build()!)
    }
}
