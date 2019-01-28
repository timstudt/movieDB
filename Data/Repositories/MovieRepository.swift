//
//  VideoDataProvider.swift
//  videoplayer
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation
import RxSwift

extension MovieRepository {
    enum Errors: Error {
        case requestAfterDeinit
        case malformedResponse
    }
}

extension MovieRepository {
    static func repository() -> MovieRepository {
        let networkService = MovieNetworkService.networkService()
        return MovieRepository(networkService: networkService,
                               dataBaseService: nil)
    }
}

final class MovieRepository {
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

    func getMovies() -> Single<[MovieModel]> {
        return Single<[MovieModel]>.create { [weak self] (single) -> Disposable in
            guard let strongSelf = self else {
                single(.error(Errors.requestAfterDeinit))
                return Disposables.create()
            }
            
            strongSelf.fetchMovies(single)
            return Disposables.create()
        }
    }
    
    private func fetchMovies(_ single: @escaping (SingleEvent<[MovieModel]>) -> Void) {
        let dataSource: MovieService?
        if let cache = cache {
            dataSource = cache
        } else if let networkService = networkService {
            dataSource = networkService
        } else {
            assertionFailure("unexpectedly found no data source for \(#file)")
            dataSource = nil
        }
        
        dataSource?.fetch { [weak self] response in
            self?.onDidFetchResponse(response, single: single)
        }
    }
    
    private func onDidFetchResponse(_ response: DataProviderResponse<[MovieModel]>, single: (SingleEvent<[MovieModel]>) -> Void) {
        if let data = response.data {
            single(.success(data))
        } else if let error = response.error {
            single(.error(error))
        }
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
