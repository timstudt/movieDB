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

extension MovieDBAPI {

    // MARK: - endpoints

    var endpointVersion: String { return "3" }
    var configurationEndpoint: String { return "configuration" }

    var defaultURLBuilder: URLBuilder {
        //swiftlint:disable force_try
        let builder = try! URLBuilder(baseURL: baseURL)
        //swiftlint:enable force_try
        builder
            .add(path: endpointVersion)
            .defaultQueryItems = [APIKeyQuery()]
        return builder
    }

    // MARK: - query items

    func APIKeyQuery() -> URLQueryItem { return URLQueryItem(name: "api_key", value: APIKey) }
    func queryQuery(_ value: String) -> URLQueryItem { return URLQueryItem(name: "query", value: value) }

    // MARK: - requests

//    func request(for endpoint: Endpoint) -> URLRequest {
//        let builder = urlRequestBuilder(url: url(for: endpoint))
//        return builder
//            .add(method: endpoint.method)
//            .build()
//    }
//
    func getMovie(id: Int) -> URLRequest {
        let endpoint = MovieEndpoint(id: id)
        return parse(endpoint: endpoint,
                     method: .get)
    }

    func searchMovie(query: String) -> URLRequest {
        let endpoint = SearchEndpoint(entity: .movie,
                                      query: query)
        return parse(endpoint: endpoint,
                     method: .get)
    }

    func getImage(resource: String, size: String = "w300") -> URLRequest {
        do {
            let urlBuilder = try URLBuilder(baseURL: MovieDBNetwork.Configuration.defaultImageURL)
                .add(path: size)
                .add(path: resource)
            return buildRequest(url: try urlBuilder.build())
        } catch {
            print(error)
            assertionFailure("API: invalid url")
            return .init(url: baseURL)
        }
    }

    private func parse(endpoint: Endpoint,
                       method: HTTPMethod,
                       customURLBuilder: URLBuilder? = nil) -> URLRequest {
        guard endpoint.isAllowed(method: method) else {
            assertionFailure("API: method not allowed: \(method)")
            return .init(url: baseURL)
        }
        let urlBuilder = customURLBuilder ?? defaultURLBuilder
        do {
            let url = try endpoint.url(builder: urlBuilder)
            return buildRequest(url: url)
        } catch {
            print(error)
            assertionFailure("API: invalid url")
            return .init(url: baseURL)
        }
    }
}
