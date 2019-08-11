//
//  VideoDataProvider.swift
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation
import RxSwift

// TODO: delete mock
final class MovieServiceDataBaseMock: MovieService {
    private var mockData: [MovieModel] {
        let names: [Int] = Array(0..<7)
        return names.map { .init(id: 1, name: "movie\($0)", caption: "blabla", imagePath: nil)}
    }

    func fetch(id: Int, completion: ((DataProviderResponse<MovieModel>) -> Void)?) {
        completion?((mockData.first, nil))
    }

    func search(query: String?, completion: ((DataProviderResponse<[MovieModel]>) -> Void)?) {
        completion?((mockData, nil))
    }
}

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

    @available(*, deprecated, message: "use searchMovies:query")
    func getMovies() -> Single<[MovieModel]> {
        return Single<[MovieModel]>.create { [weak self] (single) -> Disposable in
            let disposable = Disposables.create()
            guard let strongSelf = self else {
                single(.error(Errors.requestAfterDeinit))
                return disposable
            }

            strongSelf.fetchMovies(
                query: "Hello",
                single: single
            )
            return disposable
        }
    }

    func searchMovies(
        query: String? = nil
    ) -> Single<[MovieModel]> {
        return Single<[MovieModel]>.create { [weak self] (single) -> Disposable in
            let disposable = Disposables.create()
            guard let strongSelf = self else {
                single(.error(Errors.requestAfterDeinit))
                return disposable
            }

            strongSelf.fetchMovies(
                query: query,
                single: single
            )
            return disposable
        }
    }

    private func fetchMovies(
        query: String? = nil,
        single: @escaping (SingleEvent<[MovieModel]>) -> Void
    ) {
        networkService?.search(
            query: query
        ) { [weak self] response in
            self?.map(response, single: single)
        }
    }

    private func map(
        _ response: DataProviderResponse<[MovieModel]>,
        single: (SingleEvent<[MovieModel]>
    ) -> Void) {
        if let data = response.data {
            single(.success(data))
        } else if let error = response.error {
            single(.error(error))
        }
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
