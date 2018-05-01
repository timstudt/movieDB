//
//  Serializer.swift
//  MovieDB
//
//  Created by Tim Studt on 02/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

extension MovieDBNetwork {
    struct Serializer: Serializable {
        func serialize<T>(data: Data) throws -> [T] where T: Decodable {
            do {
                let decoder = JSONDecoder()
                let response: MovieDBNetwork.Response<T> =
                    try decoder.decode(MovieDBNetwork.Response<T>.self, from: data)
                return response.results
            } catch let err {
                print("Err", err)
                throw NetworkError.decodingFailed
            }
        }
    }
}

protocol Serializable {
    func serialize<T>(data: Data) throws -> [T] where T: Decodable
}

extension Serializable {
    func serialize<T>(data: Data) throws -> T where T: Decodable {
        do {
            let decoder = JSONDecoder()
            let response: T = try decoder.decode(T.self, from: data)
            return response
        } catch let err {
            print("Err", err)
            throw NetworkError.decodingFailed
        }
    }
    /**
     default serialize method
     */
    func serialize<T>(data: Data) throws -> [T] where T: Decodable {
        throw NetworkError.decodingFailed
    }
}
