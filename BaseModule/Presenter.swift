//
//  Presenter.swift
//  videoplayer
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

class Presenter: NSObject, ViewDataSource {
    //MARK: - Module
    weak var userInterface: PresenterOutput?
    
    //MARK: - ViewDataSource
    func loadData() { }
}
