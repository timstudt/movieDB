//
//  Alamofire.swift
//  MovieDB
//
//  Created by Tim Studt on 01/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Alamofire

struct AlamofireConnector: NetworkProvider {
    var logger: NetworkLoggable?
    
    init(logger: NetworkLoggable? = NetworkLogger()) {
        self.logger = logger
    }
    
    func send(request: URLRequest, completion: @escaping (DataProviderResponse<Data>) -> Void) {
        Alamofire
            .request(request)
            .validate()
            .responseData { (response) in
                self.logger?.log(response: response.response)
                completion((response.value, response.error))
        }
    }

    func send<T>(request: URLRequest, serializer: Serializable?,
                 completion: @escaping (DataProviderResponse<[T]>) -> Void) where T: Decodable {
        Alamofire
            .request(request)
            .validate()
            .responseSerialization(
                serializer: serializer,
                logger: logger,
                completionHandler: completion)
    }
}

extension Alamofire.DataRequest {
    @discardableResult
    func responseSerialization<T>(
        serializer: Serializable?,
        logger: NetworkLoggable? = nil,
        completionHandler: @escaping (DataProviderResponse<[T]>) -> Void)
        -> Self where T : Decodable {
            return responseData { (response) in
                logger?.log(response: response.response)
                completionHandler(
                    self.mapped(response: response,
                                serializer: serializer))
            }
    }

    private func mapped<T>(response: Alamofire.DataResponse<Data>, serializer: Serializable?) -> DataProviderResponse<[T]> where T : Decodable {
        var data: [T]?
        var error: Error?
        switch response.result {
        case .success(let value):
            data = serializer?.serialize(data: value)
        case .failure(let err):
            error = err
        }
        return DataProviderResponse(data, error)
    }
}
