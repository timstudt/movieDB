//
//  ConnectionManager.swift
//  MovieDB
//
//  Created by Tim Studt on 01/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

protocol NetworkProvider {
    func send(request: URLRequest, completion: ((DataProviderResponse<Data>) -> Void)?)
    func send<T: Decodable>(request: URLRequest,
                            serializer: Serializable?,
                            completion: ((DataProviderResponse<[T]>) -> Void)?)
}
