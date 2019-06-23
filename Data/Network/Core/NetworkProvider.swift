//
//  ConnectionManager.swift
//  MovieDB
//
//  Created by Tim Studt on 01/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

protocol NetworkProvider: DataRequestable {
    var logger: NetworkLoggable? { get set }
}

protocol DataRequestable {
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

protocol ImageDownloadRequestable {
    @discardableResult
    func download(
        request: URLRequest,
        progress: @escaping (Progress) -> Void,
        completion: @escaping (DataProviderResponse<Data>) -> Void)
        -> NetworkTask
}
