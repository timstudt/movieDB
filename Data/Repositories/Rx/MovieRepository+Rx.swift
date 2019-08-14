//
//  MovieRepository.Rx.swift
//  MovieDB
//
//  Created by Tim Studt on 14/08/2019.
//  Copyright © 2019 Tim Studt. All rights reserved.
//

import Foundation
import RxSwift

/// Rx Wrapper Interface for MovieRepositoryProtocol
extension MovieRepositoryProtocol {
    func searchMovies(
        query: String? = nil
    ) -> Single<[MovieModel]> {
        return .create { single -> Disposable in
            let task = self.searchMovies(query: query) { response in
                self.map(response, single: single)
            }
            return Disposables.create { task?.cancel() }
        }
    }

    private func map<T>(
        _ response: DataProviderResponse<T>,
        single: (SingleEvent<T>
    ) -> Void) {
        if let data = response.data {
            single(.success(data))
        } else if let error = response.error {
            single(.error(error))
        }
    }
}
