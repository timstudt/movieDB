//
//  ImageDownloader.swift
//  MovieDB
//
//  Created by Tim Studt on 10/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation
import UIKit

extension ImageDownloader {
    static func downloader() -> ImageDownloader {
        let connector = AlamofireConnector()
        let networkService = ImageDownloader(
            networkProvider: connector,
            api: MovieDBNetwork.APIClient())
        return networkService
    }
}

class ImageDownloader: NetworkService<MovieDBNetwork.APIClient>, ImageDataProvider {
    static let shared = ImageDownloader.downloader()
    
    deinit {
        print("")
    }
    func downloadImage(relativePath: String, completion: ((DataProviderResponse<UIImage>) -> Void)?) {
        //TODO
//        guard let downloader = networkProvider as? ImageDownloadRequestable,
//        let request = api?.getImage(path: relativePath)
//        else { return }
//        downloader.download(request: request, progress: { (progr) in
//            print(progr)
//        }) { response in
//            completion?(response)
//        }
    }
}

