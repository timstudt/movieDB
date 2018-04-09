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
    
    @discardableResult
    func send(request: URLRequest,
              completion: @escaping (DataProviderResponse<Data>) -> Void)
        -> NetworkTask {
        return Alamofire
            .request(request)
            .validate()
            .responseData { (response) in
                self.logger?.log(response: response.response)
                completion((response.value, response.error))
        }
    }

    @discardableResult
    func send<T>(request: URLRequest,
                 serializer: Serializable?,
                 completion: @escaping (DataProviderResponse<[T]>) -> Void)
        -> NetworkTask where T: Decodable {
        return Alamofire
            .request(request)
            .validate()
            .responseSerialization(
                serializer: serializer,
                logger: logger,
                completionHandler: completion)
    }
}

extension Alamofire.DataRequest: NetworkTask {
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

    private func mapped<T>(response: Alamofire.DataResponse<Data>,
                           serializer: Serializable?)
        -> DataProviderResponse<[T]> where T: Decodable {
        var data: [T]?
        var error: Error?
        switch response.result {
        case .success(let value):
            do {
                guard let serializer = serializer else { return DataProviderResponse(nil, NetworkError.missingSerializer) }
                let serializedData: [T] = try serializer.serialize(data: value)
                data = serializedData
            } catch let err {
                print("NetworkProvider Error", err)
                error = err
            }
        case .failure(let err):
            error = err
        }
        return DataProviderResponse(data, error)
    }
}