//
//  ImageNetworkService.swift
//  MovieDB
//
//  Created by Tim Studt on 22/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

extension ImageNetworkService {
    static func networkService() -> ImageNetworkService {
        #if TESTING
        let connector = URLSessionConnector()
        #else
        let connector = AlamofireConnector()
        #endif //TESTING
        let networkService = ImageNetworkService(
            networkProvider: connector,
            api: MovieDBNetwork.APIClient())
        return networkService
    }
}

/**
 ImageDownloader - implements the ImageService and makes the calls to the MovieDB API using the specified NetworkService
 */
final class ImageNetworkService: NetworkService<MovieDBNetwork.APIClient>, ImageService {

    //    var defaultSerializer: Serializable?

    // MARK: - ImageService
    func downloadImage(relativePath: String, completion: ((DataProviderResponse<Data>) -> Void)?) {
        guard let request = api?.getImage(resource: relativePath) else { completion?((nil, nil)); return }
        if let imageDownloader = networkProvider as? ImageDownloadRequestable {
            imageDownloader.download(
                request: request,
                progress: { _ in },
                completion: { (response: DataProviderResponse<Data>) in
                    completion?(response)
            })
        }
    }
}
