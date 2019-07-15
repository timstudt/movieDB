//
//  MovieEndpoint.swift
//  MovieDB
//
//  Created by Tim Studt on 14/07/2019.
//  Copyright © 2019 Tim Studt. All rights reserved.
//

import Foundation

struct MovieEndpoint: Endpoint {
    //swiftlint:disable identifier_name
    let id: Int
    var path: String { return "movie" } // TODO: make endpoint enum
    var allowedMethods: [HTTPMethod] { return [.get] }

    func url(builder: URLBuilder) throws -> URL {
        return try builder
            .add(path: path)
            .add(path: "\(id)")
            .build()
    }
}
