//
//  CollectionViewDataSource.swift
//  MovieDB
//
//  Created by Tim Studt on 09/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import UIKit

//public protocol ConfigurableCell: ReusableCell {
//    static var configurator: C { get }
//    associatedtype C: UICellConfigurable
//    associatedtype M
//}
//
public class CollectionViewDataSource<CellConfiguratorType: NSObject>: NSObject,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
where
    CellConfiguratorType: UICollectionViewCellConfigurable {

    var data: [CellConfiguratorType.Model]? {
        didSet { collectionView?.reloadData() }
    }

    weak var collectionView: UICollectionView? {
        didSet { setup() }
    }
    var cellConfigurator: CellConfiguratorType?

    init(
        cellConfigurator: CellConfiguratorType?
    ) {
        self.cellConfigurator = cellConfigurator
        super.init()
    }

    func setup() {
        collectionView?.register(
            CellConfiguratorType.Cell.self,
            forCellWithReuseIdentifier: CellConfiguratorType.reuseIdentifier)
        collectionView?.dataSource = self
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CellConfiguratorType.reuseIdentifier,
            for: indexPath)
        if let cell = cell as? CellConfiguratorType.Cell,
            let item = data?[indexPath.row] {
            cellConfigurator?.configure(cell, with: item)
        } else {
            assert(false, "unregisted cell type - \(cell)")
        }
        return cell
    }
}
//class CollectionViewCellFactory<CellType: UICollectionViewCell> {
//    func cell<T>(collectionView: UICollectionView, data:T, indexPath: IndexPath) -> UICollectionViewCell {
//        return CellType
//    }
//}
