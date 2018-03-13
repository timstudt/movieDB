//
//  VideoDataProvider.swift
//  videoplayer
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

class VideoDataProvider {//: DataSource {
    //MARK: - DataServices
    var dataService: Any?

    let videos: [VideoModel] = [.batman, .spiderman, .superman]
    let error: Error? = nil

    //MARK: - DataSource implementation
    func loadData(completion: ((DataProviderResponse<[VideoModel]>) -> Void)?) {
        completion?((videos, error))
    }
}
