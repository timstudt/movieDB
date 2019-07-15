//
//  ImageRepository.swift
//  MovieDB
//
//  Created by Tim Studt on 01/05/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

final class ImageRepository {
    // MARK: - DataServices
    var networkService: ImageService?
    var cache: ImageService?

    init(networkService: ImageService? = nil,
         dataBaseService: ImageService? = nil) {
        self.networkService = networkService
        self.cache = dataBaseService
    }

    // MARK: - DataSource implementation
    func loadImageData(path: String, completion: ((DataProviderResponse<Data>) -> Void)?) {
        if let _ = cache {
//            cache.downloadImage(relativePath: path, completion: completion)
        } else if let networkService = networkService {
            networkService.downloadImage(relativePath: path, completion: completion)
        }
    }
}

extension ImageRepository {
    static func makeRepository() -> ImageRepository {
        let networkService = ImageNetworkService.networkService()
        return ImageRepository(networkService: networkService,
                               dataBaseService: nil)
    }
}
