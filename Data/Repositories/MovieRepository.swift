//
//  VideoDataProvider.swift
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

// TODO: delete mock
//final class MovieServiceDataBaseMock: MovieService {
//    private var mockData: [MovieModel] {
//        let names: [Int] = Array(0..<7)
//        return names.map { .init(id: 1, name: "movie\($0)", caption: "blabla", imagePath: nil)}
//    }
//
//    func fetch(id: Int, completion: ((DataProviderResponse<MovieModel>) -> Void)?) {
//        completion?((mockData.first, nil))
//    }
//
//    func search(query: String?, completion: ((DataProviderResponse<[MovieModel]>) -> Void)?) {
//        completion?((mockData, nil))
//    }
//}

final class MovieRepository: MovieRepositoryProtocol {
    enum Errors: Error {
        case requestAfterDeinit
        case malformedResponse
    }

    // MARK: - DataServices

    let networkService: MovieService?
    let cache: MovieService?
//    let parser: Parser<[MovieModel]>

    init(networkService: MovieService? = nil,
         dataBaseService: MovieService? = nil) {
//         parser: Parser<[MovieModel]> = .init()) {
        self.networkService = networkService
        self.cache = dataBaseService
//        self.parser = parser
    }

    // MARK: - DataSource implementation

    func searchMovies(
        query: String? = nil,
        completion: ((DataProviderResponse<[MovieModel]>) -> Void)?
    ) -> NetworkTask? {
        let dataSource: MovieService?
        if let cache = cache {
            dataSource = cache
        } else if let networkService = networkService {
            dataSource = networkService
        } else {
            assertionFailure("unexpectedly found no data source for \(#file)")
            dataSource = nil
        }

        return dataSource?.search(
            query: query,
            completion: completion
        )
    }
}

extension MovieRepository {
    static func makeRepository() -> MovieRepository {
        let networkService = MovieNetworkService.makeNetworkService()
        return MovieRepository(networkService: networkService,
                               dataBaseService: nil)//MovieServiceDataBaseMock())
    }
}

//struct Parser<T> {
//    func parse<T>(single: Single<T>) -> ((DataProviderResponse<T>) -> Void) {
//        return { response in
//            if let data = response.data {
//                single(.success(data))
//            } else {
//                let error = response.error ?? Errors.malformedResponse
//                single(.error(error))
//            }
//        }
//    }
//
//}
