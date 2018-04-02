//
//  Alamofire.swift
//  MovieDB
//
//  Created by Tim Studt on 01/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Alamofire

struct AlamofireConnector: NetworkProvider {
    func send(request: URLRequest, completion: ((DataProviderResponse<Data>) -> Void)?) {
        Alamofire
            .request(request)
            .validate()
            .responseData { (response) in
            completion?((response.value, response.error))
        }
    }
    
    func send<T>(request: URLRequest, serializer: Serializable?, completion: ((DataProviderResponse<[T]>) -> Void)?) where T: Decodable {
        Alamofire
            .request(request)
            .validate()
            .responseData { (response) in
                var data: [T]?
                var error: Error?
                switch response.result {
                case .success(let value):
                    data = serializer?.serialize(data: value)
                case .failure(let err):
                    error = err
                }
                completion?((data, error))
        }
    }
}
