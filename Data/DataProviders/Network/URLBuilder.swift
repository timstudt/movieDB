//
//  URLBuilder.swift
//  MovieDB
//
//  Created by Tim Studt on 07/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

class URLBuilder {
    var components: URLComponents!
    var defaultQueryItems: [URLQueryItem]? {
        didSet {
            guard let defaultQueryItems = defaultQueryItems else { components?.queryItems = nil; return }
            add(queries: defaultQueryItems)
        }
    }
    
    init(baseURL: URL) {
        components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
    }
    
    @discardableResult
    func add(path: String) -> URLBuilder {
        var url = components?.url
        url?.appendPathComponent(path)
        if let newPath = url?.path {
            components?.path = newPath
        }
        return self
    }
    
    @discardableResult
    func add(queries: [URLQueryItem]) -> URLBuilder {
        var currentQuery = components?.queryItems
        currentQuery?.append(contentsOf: queries)
        components?.queryItems = currentQuery ?? queries
        return self
    }
    
    @discardableResult
    func add(query: URLQueryItem) -> URLBuilder {
        var currentQuery = components?.queryItems
        currentQuery?.append(query)
        components?.queryItems = currentQuery
        return self
    }
    
    func build() -> URL? {
        return components?.url
    }
}
