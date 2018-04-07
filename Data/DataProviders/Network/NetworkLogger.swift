//
//  NetworkLogger.swift
//  MovieDB
//
//  Created by Tim Studt on 07/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

protocol NetworkLoggable {
    func log(response: URLResponse?)
}

extension NetworkLoggable {
    func log(response: URLResponse?) {
        print("Networking: \(response?.debugDescription ?? "response is nil")")
    }
}

class NetworkLogger: NetworkLoggable { }
