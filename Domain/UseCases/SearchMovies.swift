//
//  GetMovies.swift
//  MovieDB
//
//  Created by Tim Studt on 27/01/2019.
//  Copyright © 2019 Tim Studt. All rights reserved.
//

import Foundation
import RxSwift

/// Use case for fetching movies from Movies Repository
struct SearchMovies {
    typealias usecase = (_ query: String?) -> Single<[MovieModel]>

    private let repository: MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol = MovieRepository.makeRepository()) {
        self.repository = repository
    }

    /// Use case execute method
    /// - Parameter query: query String for searching movies
    func execute(query: String?) -> Single<[MovieModel]> {
        return repository
            .searchMovies(query: query)
    }
}
