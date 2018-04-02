//
//  ModuleProtocols.swift
//  videoplayer
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

protocol ViewStateProtocol {
    var isLoading: Bool { get }
    var error: Error? { get }
}

protocol PresenterOutput: class {
    func render(state: ViewStateProtocol)
}

protocol ViewDataSource {    
    func loadData()
}
