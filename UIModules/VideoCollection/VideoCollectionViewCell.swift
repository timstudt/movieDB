//
//  VideoCollectionViewCell.swift
//  videoplayer
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import UIKit
extension VideoCollectionViewCell {
    func update(with model: MovieModel) {
        titleLabel.text = model.name
    }
}

class VideoCollectionViewCell: UICollectionViewCell {
    // MARK: - subviews
    let titleLabel = UILabel()
    let imageView = UIImageView()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()

    //MARK: - view overrides
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }

    //MARK: - setup
    private func setupViews() {
        setupBorder()
        contentView.addSubview(stackView)
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 10)
    }
    private func setupBorder() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
    }
}
