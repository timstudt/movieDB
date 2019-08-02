//
//  ViewState.swift
//
//  Created by Tim Studt on 22/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

class ViewState<T>: ViewStateProtocol {
    var isLoading: Bool
    var error: Error?
    var data: [T]?

    init(isLoading: Bool = false, error: Error? = nil, data: [T]? = nil) {
        self.isLoading = isLoading
        self.error = error
        self.data = data
    }

    //    static func data<T>(_ data: [T]) -> Self {
    //        return ViewState<T>.init(data: data)
    //    }
}
