//
//  DataProvider.swift
//  videoplayer
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

public typealias DataProviderResponse<T> = (T?, Error?)
typealias DataMapper<Output: Equatable, Input: Equatable> = ([Output], [Input])

protocol DataProvider {
    func loadData<T>(completion: ((DataProviderResponse<T>) -> Void)?)
}
