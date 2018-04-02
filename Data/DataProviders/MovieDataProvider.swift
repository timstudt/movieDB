//
//  MovieDataProvider.swift
//  MovieDB
//
//  Created by Tim Studt on 02/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

protocol MovieDataProvider {
    func fetch(completion: ((DataProviderResponse<[MovieModel]>) -> Void)?)
    func fetch(id: Int, completion: ((DataProviderResponse<MovieModel>)-> Void)?)
    func search(query: String?, completion: ((DataProviderResponse<[MovieModel]>) -> Void)?)
}
