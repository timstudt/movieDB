//
//  UICollectionViewCellConfigurable.swift
//  MovieDB
//
//  Created by Tim Studt on 11/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import UIKit

public protocol UICellConfigurable {
    associatedtype Cell
    associatedtype Model
    func configure(_ cell: Cell, with model: Model)
}

public protocol UICollectionViewCellConfigurable: UICellConfigurable,
    ReusableCell
where Cell: UICollectionViewCell { }
