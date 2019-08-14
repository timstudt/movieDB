//
//  MovieRepositoryProtocol.swift
//  MovieDB
//
//  Created by Tim Studt on 11/08/2019.
//  Copyright © 2019 Tim Studt. All rights reserved.
//

import Foundation

/// The Interface for Movie repositories
protocol MovieRepositoryProtocol {
    func searchMovies(
        query: String?,
        completion: ((DataProviderResponse<[MovieModel]>) -> Void)?
    ) -> NetworkTask?
}
