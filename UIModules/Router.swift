//
//  Router.swift
//  videoplayer
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import UIKit

struct Router {
    enum ViewType {
        case videoCollection
    }
    
    static let shared = Router()

    weak var current: View?
    
    static func show(type: ViewType) -> View {
        var router = shared
        return router.show(type: type)
    }
    
    mutating func show(type: ViewType) -> View {
        var nextView: View!
        switch type {
        case .videoCollection:
            nextView = VideoCollectionViewController.newView()
        }
        current = nextView
        return nextView
    }
}
