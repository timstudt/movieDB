//
//  VideoDataProvider.swift
//  videoplayer
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

extension MovieRepository {
    static func repository() -> MovieRepository {
        let networkService = MovieNetworkService.networkService()
        return MovieRepository(networkService: networkService,
                               dataBaseService: nil)
    }
}

class MovieRepository {
    // MARK: - DataServices
    var networkService: MovieDataProvider?
    var dataBaseService: MovieDataProvider?

    init(networkService: MovieDataProvider? = nil, dataBaseService: MovieDataProvider? = nil) {
        self.networkService = networkService
        self.dataBaseService = dataBaseService
    }

    // MARK: - DataSource implementation
    func loadData(completion: ((DataProviderResponse<[MovieModel]>) -> Void)?) {
        if let networkService = networkService {
            networkService.fetch(completion: completion)
        } else if let dataBaseService = dataBaseService {
            dataBaseService.fetch(completion: completion)
        }
    }
}
