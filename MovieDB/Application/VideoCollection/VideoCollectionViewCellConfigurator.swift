//
//  VideoCollectionViewCellConfigurator.swift
//  MovieDB
//
//  Created by Tim Studt on 11/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import UIKit

final class VideoCollectionViewCellConfigurator: NSObject, UICollectionViewCellConfigurable {
    typealias Cell = VideoCollectionViewCell
    typealias Model = MovieModel

    private let imageRepo: ImageRepository

    init(imageRepository: ImageRepository = .repository()) {
        self.imageRepo = imageRepository
        super.init()
    }

    func configure(_ cell: VideoCollectionViewCell, with model: MovieModel) {
        cell.titleLabel.text = model.name
        if let imagePath = model.imagePath {
            imageRepo.loadImageData(path: imagePath) { [weak cell] (response) in
                guard let imageData = response.data else { return }
                let image = UIImage(data: imageData)
                cell?.imageView.image = image
            }
        }
    }
}
