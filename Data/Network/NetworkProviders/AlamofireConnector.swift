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
    let sessionManager = Alamofire.SessionManager.default
    
    init(logger: NetworkLoggable? = NetworkLogger()) {
        self.logger = logger
    }
    
    @discardableResult
    func send(request: URLRequest,
              completion: @escaping (DataProviderResponse<Data>) -> Void)
        -> NetworkTask {
        return sessionManager
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
        return sessionManager
            .request(request)
            .validate()
            .responseSerialization(
                serializer: serializer,
                logger: logger,
                completionHandler: completion)
    }
}

extension AlamofireConnector: ImageDownloadRequestable {
    func download(request: URLRequest,
                  progress: @escaping (Progress) -> Void,
                  completion: @escaping (DataProviderResponse<Data>) -> Void)
        -> NetworkTask {
        
        return sessionManager
            .request(request)
            .validate()
            .responseDataParser(
                logger: logger,
                completionHandler: completion)
    }
}

extension Alamofire.DataRequest: NetworkTask {
    @discardableResult
    func responseDataParser(
        logger: NetworkLoggable? = nil,
        completionHandler: @escaping (DataProviderResponse<Data>) -> Void)
        -> Self {
        return
            log(logger)
            .responseData { (response) in
                let mappedResponse = self.mapped(response: response)
                completionHandler(mappedResponse)
        }
    }

    @discardableResult
    func responseSerialization<T>(
        serializer: Serializable?,
        logger: NetworkLoggable? = nil,
        completionHandler: @escaping (DataProviderResponse<[T]>) -> Void)
        -> Self where T : Decodable {
        return
            log(logger)
            .responseData { (response) in
            completionHandler(
                self.mapped(response: response,
                            serializer: serializer))
        }
    }
    
    //MARK: - Logging
    func log(_ logger:NetworkLoggable? = nil) -> Self {
        logger?.log(response: self.response)
        return self
    }
    
    //MARK: - Mapping
    private func mapped(response: Alamofire.DataResponse<Data>)
        -> DataProviderResponse<Data> {
            return (response.data, response.error)
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
