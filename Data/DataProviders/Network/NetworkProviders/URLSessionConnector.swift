//
//  URLSessionConnector.swift
//  MovieDB
//
//  Created by Tim Studt on 02/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

struct URLSessionConnector: NetworkProvider {
    var logger: NetworkLoggable?
    private let session: URLSession = .shared

    init(logger: NetworkLoggable? = NetworkLogger()) {
        self.logger = logger
    }

    func send(request: URLRequest,
              completion: @escaping (DataProviderResponse<Data>) -> Void) {
        session
            .dataTask(with: request) { (data, response, error) in
                self.logger?.log(response: response)
                completion((data, error))
            }.resume()
    }

    func send<T>(request: URLRequest,
                 serializer: Serializable?,
                 completion: @escaping (DataProviderResponse<[T]>) -> Void) where T: Decodable {
        session
            .dataTask(with: request) { (data, response, error) in
                self.logger?.log(response: response)
                let result: DataProviderResponse<[T]> =
                    self.mapped(data: data,
                                error: error,
                                serializer: serializer)
                completion(result)
            }
            .resume()
    }
    
    private func mapped<T>(data: Data?,
                           error: Error?,
                           serializer: Serializable?) -> DataProviderResponse<[T]> where T : Decodable {
        var results: [T]?
        if let data = data {
            results = serializer?.serialize(data: data)
        }
        return DataProviderResponse(results, error)
    }

}
