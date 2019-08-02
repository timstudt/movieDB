//
//  URLRequestBuilder.swift
//  Marvelicious
//
//  Created by Tim Studt on 11/05/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

public class URLRequestBuilder {
    private(set) var urlRequest: URLRequest

    init(url: URL) {
        urlRequest = URLRequest(url: url)
    }

    @discardableResult
    func add(method: HTTPMethod) -> URLRequestBuilder {
        urlRequest.httpMethod = method.rawValue
        return self
    }

    @discardableResult
    func add(cachePolicy: URLRequest.CachePolicy) -> URLRequestBuilder {
        urlRequest.cachePolicy = cachePolicy
        return self
    }

    @discardableResult
    func add(timeoutInterval: TimeInterval) -> URLRequestBuilder {
        urlRequest.timeoutInterval = timeoutInterval
        return self
    }

    @discardableResult
    func add(headerFields: [String: String]) -> URLRequestBuilder {
        headerFields.forEach { (key, value) in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        return self
    }

    @discardableResult
    func add(allHeaderFields: [String: String]) -> URLRequestBuilder {
        urlRequest.allHTTPHeaderFields = allHeaderFields
        return self
    }

    func build() -> URLRequest {
        return urlRequest
    }
}
