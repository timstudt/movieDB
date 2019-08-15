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
    private var acceptableStatusCodes: [Int] {
        return Array(200..<300)
    }
    
    
    init(logger: NetworkLoggable? = NetworkLogger()) {
        self.logger = logger
    }

    @discardableResult
    func send(request: URLRequest,
              completion: @escaping (DataProviderResponse<Data>) -> Void)
        -> NetworkTask {
        let task = session
            .dataTask(with: request) { (data, response, error) in
                self.logger?.log(response: response)
                completion((data, error))
            }
        task.resume()
        return task
    }

    @discardableResult
    func send<T>(request: URLRequest,
                 serializer: Serializable?,
                 completion: @escaping (DataProviderResponse<[T]>) -> Void)
        -> NetworkTask where T: Decodable {
        let task = session
            .dataTask(with: request) { (data, response, error) in
                self.logger?.log(response: response)
                do {
                    try self.validate(response: response)
                    let result: DataProviderResponse<[T]> =
                        self.mapped(data: data,
                                    error: error,
                                    serializer: serializer)
                    completion(result)
                } catch let validationError {
                    completion((nil, validationError))
                    return
                }
            }
        task.resume()
        return task
    }

    private func mapped<T>(data: Data?,
                           error: Error?,
                           serializer: Serializable?)
        -> DataProviderResponse<[T]> where T: Decodable {
        var outputData: [T]?
        var outputError: Error?
        if let data = data {
            do {
                guard let serializer = serializer else { return DataProviderResponse(nil, NetworkError.missingSerializer) }
                let serializedData: [T] = try serializer.serialize(data: data)
                outputData = serializedData
                outputError = error
            } catch let err {
                print("NetworkProvider Error", err)
                outputError = err
            }
        }
        return DataProviderResponse(outputData, outputError)
    }
    
    private func validate(response: URLResponse?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw(NetworkError.unexpectedResponseType)
        }
        guard acceptableStatusCodes.contains(httpResponse.statusCode) else {
            throw(NetworkError.invalidStatusCode(httpResponse.statusCode))
        }
    }
}

extension URLSessionTask: NetworkTask { }
