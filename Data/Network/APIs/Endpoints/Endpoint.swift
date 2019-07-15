//
//  Endpoint.swift
//  MovieDB
//
//  Created by Tim Studt on 14/07/2019.
//  Copyright © 2019 Tim Studt. All rights reserved.
//

import Foundation

protocol Endpoint {
    var allowedMethods: [HTTPMethod] { get }
    func isAllowed(method: HTTPMethod) -> Bool
    func url(builder: URLBuilder) throws -> URL
}

extension Endpoint {
    func isAllowed(method: HTTPMethod) -> Bool {
        return allowedMethods.contains(method)
    }
}
