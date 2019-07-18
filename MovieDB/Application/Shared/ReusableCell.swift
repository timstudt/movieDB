//
//  ReusableCell.swift
//  MovieDB
//
//  Created by Tim Studt on 14/07/2019.
//  Copyright © 2019 Tim Studt. All rights reserved.
//

import Foundation

public protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

public extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
