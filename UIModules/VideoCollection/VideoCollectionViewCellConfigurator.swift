//
//  VideoCollectionViewCellConfigurator.swift
//  MovieDB
//
//  Created by Tim Studt on 11/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import UIKit

class VideoCollectionViewCellConfigurator: NSObject, UICollectionViewCellConfigurable {
    typealias Cell = VideoCollectionViewCell
    typealias Model = MovieModel
    
    func configure(_ cell: VideoCollectionViewCell, with model: MovieModel) {
        cell.titleLabel.text = model.name
        cell.imageView.setImage(url: model.imageURL)
    }
}
