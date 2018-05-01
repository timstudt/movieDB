//
//  HTTPMethod.swift
//  MovieDB
//
//  Created by Tim Studt on 10/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
