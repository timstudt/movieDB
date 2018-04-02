//
//  ListDataProvider.swift
//  MovieDB
//
//  Created by Tim Studt on 02/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

protocol ListDataProvider {
    func fetch<T>(completion: (([T]?, Error?) -> Void)?)
    func fetch<T>(id: Int, completion: ((T?, Error?) -> Void)?)
    func search<T>(query: String?, completion: (([T]?, Error?) -> Void)?)
}
