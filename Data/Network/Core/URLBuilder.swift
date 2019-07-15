//
//  URLBuilder.swift
//  MovieDB
//
//  Created by Tim Studt on 07/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

class URLBuilder {
    enum Error: Swift.Error {
        case invalidBaseURL
        case unresolvableURL
    }

    var components: URLComponents
    var defaultQueryItems: [URLQueryItem]? {
        didSet {
            guard let defaultQueryItems = defaultQueryItems else { components.queryItems = nil; return }
            add(queries: defaultQueryItems)
        }
    }

    init(baseURL: URL) throws {
        guard let components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        else {
            throw Error.invalidBaseURL
        }
        self.components = components
    }

    @discardableResult
    func add(path: String) -> URLBuilder {
        var url = components.url
        url?.appendPathComponent(path)
        if let newPath = url?.path {
            components.path = newPath
        }
        return self
    }

    @discardableResult
    func add(queries: [URLQueryItem]) -> URLBuilder {
        var currentQuery = components.queryItems
        currentQuery?.append(contentsOf: queries)
        components.queryItems = currentQuery ?? queries
        return self
    }

    @discardableResult
    func add(query: URLQueryItem) -> URLBuilder {
        var currentQuery = components.queryItems
        currentQuery?.append(query)
        components.queryItems = currentQuery
        return self
    }

    func build() throws -> URL {
        guard let url = components.url
        else {
            throw Error.unresolvableURL
        }
        return url
    }
}
