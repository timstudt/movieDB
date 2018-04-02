//
//  URLSessionConnector.swift
//  MovieDB
//
//  Created by Tim Studt on 02/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

struct URLSessionConnector: NetworkProvider {

    var session: URLSession = .shared

    func send(request: URLRequest, completion: ((DataProviderResponse<Data>) -> Void)?) {
        session
            .dataTask(with: request) { (data, _, error) in
                completion?((data, error))
            }.resume()
    }

    func send<T>(request: URLRequest,
                 serializer: Serializable?,
                 completion: ((DataProviderResponse<[T]>) -> Void)?) where T: Decodable {
        session
            .dataTask(with: request) { (data, _, error) in
                var results: [T]?
                if let data = data {
                    results = serializer?.serialize(data: data)
                }
                completion?((results,
                             error))
        }.resume()
    }
}
