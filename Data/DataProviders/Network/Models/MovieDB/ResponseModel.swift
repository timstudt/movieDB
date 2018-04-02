//
//  MovieDBResponseModel.swift
//  MovieDB
//
//  Created by Tim Studt on 31/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

enum MovieDBNetwork {
    ///the response model all resources are wrapped in
    struct Response<Result: Decodable>: Decodable {
        var page: Int
        var totalPages: Int
        var totalResults: Int
        var results: [Result]

        private enum CodingKeys: String, CodingKey {
            case page
            case totalPages = "total_pages"
            case totalResults = "total_results"
            case results
        }
    }
}

