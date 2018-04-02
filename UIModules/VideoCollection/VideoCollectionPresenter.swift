//
//  VideoCollectionPresenter.swift
//  videoplayer
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation
extension VideoCollectionPresenter {
    static func newPresenter() -> VideoCollectionPresenter {
        let presenter = VideoCollectionPresenter()
        presenter.repository = MovieRepository.repository()
        return presenter
    }    
}

class VideoCollectionPresenter: Presenter {
    typealias Response = DataProviderResponse<[MovieModel]>

    //MARK: - Module
    private var repository: MovieRepository?
    
    //MARK: - ViewDataSource
    override func loadData() {
        repository?.loadData(completion: { [weak self] (response: Response) in
            guard let viewState = self?.viewState(for: response) else { return }
            self?.userInterface?.render(state: viewState)
        })
    }
    
    //MARK: - private methods
    private func viewState(for response: Response) -> VideoCollectionViewState {
        return VideoCollectionViewState.hasLoaded(data: response.0, error: response.1)
    }
}
