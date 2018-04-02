//
//  View.swift
//  videoplayer
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import UIKit

extension View {
    static func newView(presenter: Presenter = Presenter(), builder: ModuleBuilder = ModuleBuilder()) -> View {
        let view = self.init()
        return builder
            .add(view: view)
            .add(presenter: presenter)
            .build()
    }
}

class View: UIViewController, PresenterOutput {
    // MARK: - Module
    var dataSource: ViewDataSource?

    // MARK: - PresenterOutput
    func render(state: ViewStateProtocol) { }
}
