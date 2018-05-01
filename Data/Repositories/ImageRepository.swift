//
//  ImageRepository.swift
//  MovieDB
//
//  Created by Tim Studt on 01/05/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

extension ImageRepository {
    static func repository() -> ImageRepository {
        let networkService = ImageNetworkService.networkService()
        return ImageRepository(networkService: networkService,
                               dataBaseService: nil)
    }
}

class ImageRepository {
    // MARK: - DataServices
    var networkService: ImageDataProvider?
    var cache: ImageDataProvider?
    
    init(networkService: ImageDataProvider? = nil,
         dataBaseService: ImageDataProvider? = nil) {
        self.networkService = networkService
        self.cache = dataBaseService
    }
    
    // MARK: - DataSource implementation
    func loadImageData(path: String, completion: ((DataProviderResponse<Data>) -> Void)?) {
        if let cache = cache {
//            cache.downloadImage(relativePath: path, completion: completion)
        } else if let networkService = networkService {
            networkService.downloadImage(relativePath: path, completion: completion)
        }
    }
}