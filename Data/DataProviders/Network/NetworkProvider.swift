//
//  ConnectionManager.swift
//  MovieDB
//
//  Created by Tim Studt on 01/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

protocol NetworkProvider {
    var logger: NetworkLoggable? { get set }

    @discardableResult
    func send(
        request: URLRequest,
        completion: @escaping (DataProviderResponse<Data>) -> Void)
        -> NetworkTask
    @discardableResult
    func send<T: Decodable>(
        request: URLRequest,
        serializer: Serializable?,
        completion: @escaping (DataProviderResponse<[T]>) -> Void)
        -> NetworkTask
}
