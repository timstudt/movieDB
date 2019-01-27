//
//  VideoModel.swift
//  videoplayer
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

struct MovieModel {
    // swiftlint:disable identifier_name
    let id: Int
    // swiftlint:enable identifier_name
    let name: String?
    let caption: String?
    let imagePath: String?
}

extension MovieModel: Equatable {}
