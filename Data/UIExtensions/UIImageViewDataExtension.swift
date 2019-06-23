//
//  UIImageViewDataExtension.swift
//  MovieDB
//
//  Created by Tim Studt on 10/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {
    func setImage(url: URL?, imageDownloader: ImageDataProvider = ImageDownloader.shared) {
        guard let url = url else { image = nil; return }
        imageDownloader.downloadImage(relativePath: url.path) { [weak self] (image, _) in
            self?.image = image
        }
    }
}
