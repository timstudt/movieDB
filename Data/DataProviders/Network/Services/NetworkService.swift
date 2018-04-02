//
//  NetworkService.swift
//  videoplayer
//
//  Created by Tim Studt on 20/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

public class NetworkService<T: API> {
    var api: T?
    var networkProvider: NetworkProvider?
    //    var mapper:
    init(networkProvider: NetworkProvider?, api: T?) {
        self.networkProvider = networkProvider
        self.api = api
    }
}
