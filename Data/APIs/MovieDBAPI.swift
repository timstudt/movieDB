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
    
    //MARK: - endpoints
    var endpointVersion: String { return "3" }
    var movieEndpoint: String { return "movie" }
    var searchEndpoint: String { return "search" }
    var searchMoviePath: String { return "/\(endpointVersion)/\(searchEndpoint)/movie" }
    //MARK: - query items
    var APIKeyQuery: URLQueryItem { return URLQueryItem(name: "api_key", value: APIKey) }
    //MARK: - urls
    var searchMovieURL: URL {
        return buildURL(endpoint: searchEndpoint, pathComponent: "movie")
    }

    //MARK: - requests
    func getMovie(id: Int) -> URLRequest {
        let url = buildURL(endpoint: movieEndpoint, pathComponent: "\(id)")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [APIKeyQuery]
        return buildRequest(url: components.url!)
    }
    
    func searchMovie(query: String) -> URLRequest {
        var components = URLComponents(url: searchMovieURL, resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "query", value: query), APIKeyQuery]
        return buildRequest(url: components.url!)
    }
    
    func buildURL(endpoint: String, pathComponent: String = "") -> URL {
        return baseURL
            .appendingPathComponent(endpointVersion, isDirectory: false)
            .appendingPathComponent(endpoint)
            .appendingPathComponent(pathComponent)
    }
}
