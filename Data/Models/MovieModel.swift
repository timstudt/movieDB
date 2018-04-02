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
    var id: Int
    // swiftlint:enable identifier_name
    var name: String?
    var caption: String?
    var imageURL: URL?
}

extension MovieModel: Equatable {
    public static func == (lhs: MovieModel, rhs: MovieModel) -> Bool {
        return lhs.id == rhs.id
    }
}
