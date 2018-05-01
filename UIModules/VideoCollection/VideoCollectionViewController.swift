//
//  ViewController.swift
//  videoplayer
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import UIKit

extension VideoCollectionViewController {
    static func newView() -> VideoCollectionViewController {
        let presenter = VideoCollectionPresenter.newPresenter()
        // swiftlint:disable force_cast
        return newView(presenter: presenter) as! VideoCollectionViewController
        // swiftlint:enable force_cast
    }
}

class VideoCollectionViewController: View {
    // MARK: - Models

    // MARK: - subiews
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: 80, height: 135)
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: view.bounds,
                                              collectionViewLayout: flowLayout)
        return collectionView
    }()

    //MARK: - data sources
    lazy var collectionViewDataSource: VideoCollectionViewDataSource = {
        let dataSource = VideoCollectionViewDataSource(
            collectionView: collectionView,
            cellConfigurator: VideoCollectionViewCellConfigurator())
        return dataSource
    }()
    
    // MARK: - Constants

    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        dataSource?.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - View override
    override func render(state: ViewStateProtocol) {
        guard let state = state as? VideoCollectionViewState else { return }
        collectionViewDataSource.data = state.data
    }

    // MARK: - private methods
    private func setupViews() {
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
    }
}
