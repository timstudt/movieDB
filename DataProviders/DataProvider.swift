//
//  DataProvider.swift
//  videoplayer
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

typealias DataProviderResponse<T> = (T?, Error?)

protocol DataSource {
    func loadData<T>(completion: ((DataProviderResponse<T>) -> Void)?)
}
