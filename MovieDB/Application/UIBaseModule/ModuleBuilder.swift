//
//  ModuleBuilder.swift
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

class ModuleBuilder {
    var view: BaseView!
    var presenter: Presenter?

    @discardableResult
    func add(view: BaseView) -> Self {
        self.view = view
        return self
    }

    @discardableResult
    func add(presenter: Presenter) -> Self {
        self.presenter = presenter
        return self
    }

    func build() -> BaseView {
        view.dataSource = presenter
        presenter?.userInterface = view
        return view
    }
}
