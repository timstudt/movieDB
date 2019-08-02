//
//  NetworkService.swift
//
//  Created by Tim Studt on 20/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

/**
 NetworkService<T:API> - base class for a network service that uses a network provider to make calls to the API specified
*/
public class NetworkService<T: API> {
    let api: T?
    let networkProvider: NetworkProvider?

    init(networkProvider: NetworkProvider?, api: T?) {
        self.networkProvider = networkProvider
        self.api = api
    }
}
