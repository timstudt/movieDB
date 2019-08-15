//
//  NetworkError.swift
//  MovieDB
//
//  Created by Tim Studt on 08/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case decodingFailed
    case missingSerializer
    case invalidStatusCode(Int)
    case unexpectedResponseType
}
