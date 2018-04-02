//
//  ViewController.swift
//  videoplayer
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import UIKit

extension VideoCollectionViewController {
    static func newView() -> VideoCollectionViewController {
        let presenter = VideoCollectionPresenter.newPresenter()
        return newView(presenter: presenter) as! VideoCollectionViewController
    }
}

class VideoCollectionViewController: View {
    //MARK: - Models
    var videos: [MovieModel]?
    
    //MARK: - subiews
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: 100, height: 100)
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        return collectionView
    }()
    
    //MARK: - Constants
    let cellReuseIdentifier = "VideoCell"
    
    //MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        dataSource?.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - View override
    override func render(state: ViewStateProtocol) {
        guard let state = state as? VideoCollectionViewState else { return }
        videos = state.data
        collectionView.reloadData()
    }
    
    //MARK: - private methods
    private func setupViews() {
        collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
    }
}

//MARK: - UICollectionViewDataSource
extension VideoCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let video: MovieModel = videos![indexPath.row]
        let cell: VideoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! VideoCollectionViewCell
        cell.backgroundColor = .green
        cell.update(with: video)
        return cell
    }
}
