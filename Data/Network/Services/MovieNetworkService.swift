//
//  VideoNetworkService.swift
//  videoplayer
//
//  Created by Tim Studt on 20/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

extension MovieNetworkService {
    static func networkService() -> MovieNetworkService {
        let connector = URLSessionConnector()//AlamofireConnector()
        let networkService = MovieNetworkService(
            networkProvider: connector,
            api: MovieDBNetwork.APIClient())
        networkService.defaultSerializer = MovieDBNetwork.Serializer()
        return networkService
    }
}

/**
 MovieNetworkService - implements the MovieDataProvider and makes the calls to the MovieDB API using the specified NetworkService
 */
class MovieNetworkService: NetworkService<MovieDBNetwork.APIClient>, MovieDataProvider {
    var defaultSerializer: Serializable?

    func fetch(completion: ((DataProviderResponse<[MovieModel]>) -> Void)?) {
        search(query: "hello", completion: completion) //TODO
    }

    // swiftlint:disable identifier_name
    func fetch(id: Int, completion: ((DataProviderResponse<MovieModel>) -> Void)?) {
        guard let request = api?.getMovie(id: id) else { completion?((nil, nil)); return }
        networkProvider?.send(
            request: request,
            serializer: defaultSerializer) { (_: DataProviderResponse<[MovieDBNetwork.Movie]>) in
            print("")
            DispatchQueue.main.async {
                completion?((nil, nil)) //TODO
            }
        }
    }
    // swiftlint:enable identifier_name

    func search(query: String?, completion: ((DataProviderResponse<[MovieModel]>) -> Void)?) {
        guard let query = query,
            let request = api?.searchMovie(query: query)
            else { completion?((nil, nil)); return }

        networkProvider?
            .send(request: request,
                  serializer: defaultSerializer) { (response: DataProviderResponse<[MovieDBNetwork.Movie]>) in
            print("")
            let outputData: [MovieModel]? = response.0?.map { self.mapped(movie: $0) }
            let error = response.1
            DispatchQueue.main.async {
                completion?((outputData, error))
            }
        }
    }

    // MARK: - mapping
    func mapped(movie: MovieDBNetwork.Movie) -> MovieModel {
        let mapped = MovieModel(id: movie.id,
                                name: movie.title,
                                caption: movie.overview,
                                imagePath: movie.posterPath)
        return mapped
    }
}