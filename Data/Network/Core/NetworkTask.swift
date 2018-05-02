//
//  NetworkTask.swift
//  MovieDB
//
//  Created by Tim Studt on 08/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

protocol NetworkTask {
    func cancel()
    func resume()
    func suspend()
}
