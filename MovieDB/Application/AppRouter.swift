//
//  AppRouter.swift
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import UIKit

struct AppRouter {
    enum Scene {
        case movieCollection
    }

    let root: UINavigationController
    var window: UIWindow?
    private var coordinator: Coordinating!

    init(window: UIWindow?,
         root: UINavigationController = .init()) {
        self.root = root
        self.window = window
    }

    mutating func show(scene: Scene) {
        coordinator = coordinator(for: scene)
        coordinator.start()
        addRootToWindow()
    }

    // TODO not scalable; remove enum
    private func coordinator(for scene: Scene) -> Coordinating {
        switch scene {
        case .movieCollection:
            return MovieCollectionCoordinator(rootView: root)
        }
    }

    private func addRootToWindow() {
        guard let window = window else {
            assertionFailure("window is nil")
            return
        }
        window.rootViewController = root
        window.makeKeyAndVisible()
    }
}
