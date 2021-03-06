//
//  MovieNetworkModel.swift
//  MovieDB
//
//  Created by Tim Studt on 31/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

extension MovieDBNetwork {
    struct Movie: Codable {
        // swiftlint:disable identifier_name
        let id: Int
        let voteAverage: Double
        let title: String
        let overview: String
        let posterPath: String?

        // swiftlint:disable nesting
       private enum CodingKeys: String, CodingKey {
            case id
            case voteAverage = "vote_average"
            case title
            case overview
            case posterPath = "poster_path"

        }
    }
}
