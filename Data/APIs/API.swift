//
//  API.swift
//  MovieDB
//
//  Created by Tim Studt on 20/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

public protocol API {
    var APIKey: String { get }
    var baseURL: URL { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var timeoutInterval: TimeInterval { get }
    var allHTTPHeaderFields: [String: String] { get }
    
    var baseURLComponents: URLComponents { get }

    func buildRequest(url: URL, httpMethod: String) -> URLRequest
}

public extension API {
    var APIKey: String { return "" }
    var cachePolicy: URLRequest.CachePolicy { return .useProtocolCachePolicy }
    var timeoutInterval: TimeInterval { return 20.0 }
    var allHTTPHeaderFields: [String : String] { return [String: String]() }

    var baseURLComponents: URLComponents {
        let components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        return components!
    }

    func buildRequest(url: URL, httpMethod: String = "GET") -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = allHTTPHeaderFields
        return request
    }
}
