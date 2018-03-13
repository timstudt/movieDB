//
//  VideoModel.swift
//  videoplayer
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

struct VideoModel {
    var name: String?
    var caption: String?
    var imageURL: URL?
}
//TEst
extension VideoModel {
    static var batman: VideoModel {
        return VideoModel(name: "Batman", caption: "relklfs dlfkdlfk", imageURL: nil)
    }
    static var superman: VideoModel {
        return VideoModel(name: "Superman", caption: nil, imageURL: nil)
    }
    static var spiderman: VideoModel {
        return VideoModel(name: "Spiderman", caption: "dl dlfkdlfk", imageURL: nil)
    }
}
