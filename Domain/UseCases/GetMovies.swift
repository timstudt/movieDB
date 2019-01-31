//
//  GetMovies.swift
//  MovieDB
//
//  Created by Tim Studt on 27/01/2019.
//  Copyright © 2019 Tim Studt. All rights reserved.
//

import Foundation
import RxSwift

struct GetMovies {
    typealias usecase = () -> Single<[MovieModel]>
    
    private let repository: MovieRepository
    
    init(repository: MovieRepository = .repository()) {
        self.repository = repository
    }
    
    func execute() -> Single<[MovieModel]> {
        return repository
            .getMovies()
            .observeOn(MainScheduler.instance)
    }
}
