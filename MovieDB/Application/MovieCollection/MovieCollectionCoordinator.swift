//
//  MovieCollectionCoordinator.swift
//  MovieDB
//
//  Created by Tim Studt on 11/08/2019.
//  Copyright © 2019 Tim Studt. All rights reserved.
//

import UIKit

final class MovieCollectionCoordinator: Coordinator {
    let rootView: UINavigationController
    lazy var movieCollectionView: MovieCollectionViewController = {
        let presenter = MovieCollectionPresenter()
        // swiftlint:disable force_cast
        return MovieCollectionViewController.makeNewView(presenter: presenter) as! MovieCollectionViewController
        // swiftlint:enable force_cast
    }()

    init(rootView: UINavigationController) {
        self.rootView = rootView
    }

    // MARK: - Coordinator

    func start() {
        rootView.pushViewController(movieCollectionView, animated: true)
    }
}
