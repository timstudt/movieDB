//
//  VideoNetworkService.swift
//
//  Created by Tim Studt on 20/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

/**
 MovieNetworkService - implements the MovieService and makes the calls to the MovieDB API using the specified NetworkService
 */
final class MovieNetworkService: NetworkService<MovieDBNetwork.APIClient> {
    enum Error: Swift.Error, CaseIterable, Equatable {
        case invalidQuery, missingAPI
    }
    let defaultSerializer: Serializable?

    init(defaultSerializer: Serializable?,
         networkProvider: NetworkProvider?,
         api: MovieDBNetwork.APIClient?) {
        self.defaultSerializer = defaultSerializer
        super.init(networkProvider: networkProvider, api: api)
    }

    // MARK: - mapping

    private func map(movie: MovieDBNetwork.Movie) -> MovieModel {
        return .init(id: movie.id,
                     name: movie.title,
                     caption: movie.overview,
                     imagePath: movie.posterPath)
    }
}

extension MovieNetworkService: MovieService {
    // swiftlint:disable identifier_name
    func fetch(id: Int, completion: ((DataProviderResponse<MovieModel>) -> Void)?) {
        guard let request = api?.getMovie(id: id) else { completion?((nil, Error.missingAPI)); return }
        networkProvider?.send(
            request: request,
            serializer: defaultSerializer) { (_: DataProviderResponse<[MovieDBNetwork.Movie]>) in
            completion?((nil, nil)) // TODO
        }
    }
    // swiftlint:enable identifier_name

    /// Search movies by query string
    /// - Parameter query: String -  when nil or empty returns error
    /// - Parameter completion: handler called with result of search request
    /// - returns: a reference to the task
    func search(
        query: String?,
        completion: ((DataProviderResponse<[MovieModel]>) -> Void)?
    ) -> NetworkTask? {
        guard let query = query, !query.isEmpty else {
            completion?((nil, Error.invalidQuery)); return nil
        }
        guard let request = api?.searchMovie(query: query) else {
            completion?((nil, Error.missingAPI)); return nil }

        return networkProvider?.send(
                request: request,
                serializer: defaultSerializer
            ) { (response: DataProviderResponse<[MovieDBNetwork.Movie]>) in
                let outputData: [MovieModel]? = response.0?.map { self.map(movie: $0) }
                let error = response.1
                completion?((outputData, error))
        }
    }
}

extension MovieNetworkService {
    static func makeNetworkService() -> MovieNetworkService {
        let connector = URLSessionConnector()//AlamofireConnector()
        let networkService = MovieNetworkService(
            defaultSerializer: MovieDBNetwork.Serializer(),
            networkProvider: connector,
            api: MovieDBNetwork.APIClient())
        return networkService
    }
}
