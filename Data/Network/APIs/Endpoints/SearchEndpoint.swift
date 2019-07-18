//
//  SearchEndpoint.swift
//  MovieDB
//
//  Created by Tim Studt on 15/07/2019.
//  Copyright © 2019 Tim Studt. All rights reserved.
//

import Foundation

struct SearchEndpoint: Endpoint {
    enum Entity: String {
        case movie
    }

    var entity: Entity
    var query: String
    var allowedMethods: [HTTPMethod] { return [.get] }

    private var path: String { return "search" }

    func url(builder: URLBuilder) throws -> URL {
        return try builder
            .add(path: path)
            .add(path: entity.rawValue)
            .add(query: queryItem(query))
            .build()
    }

    private func queryItem(_ value: String) -> URLQueryItem {
        return URLQueryItem(name: "query", value: value)
    }
}
