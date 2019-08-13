//
//  MovieCollectionPresenter.swift
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation
import RxSwift

final class MovieCollectionPresenter: Presenter {
    typealias Response = Single<[MovieModel]>

    // MARK: - Module
    private let searchMovies: SearchMovies.usecase
    private let disposeBag: DisposeBag
    private let queryDebounceInterval: DispatchTimeInterval = .milliseconds(300)

    init(
        getMovies: @escaping SearchMovies.usecase = SearchMovies().execute,
        disposeBag: DisposeBag = .init()) {
        self.searchMovies = getMovies
        self.disposeBag = disposeBag
    }

    // MARK: - ViewDataSource

    override func loadData() {
        setup()
        loadData(for: nil)
    }

    // MARK: - private methods

    private func setup() {
        queryBinding()
    }

    private func queryBinding() {
        guard let movieCollectionViewController = userInterface as? MovieCollectionViewController else { return }
        movieCollectionViewController
            .queryText
            .debounce(queryDebounceInterval,
                      scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(onNext: { [weak self] (query) in
                self?.loadData(for: query)
            })
            .disposed(by: disposeBag)

    }

    private func loadData(for query: String?) {
        // TODO: load popular movies when query = nil
        searchMovies(query)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (movies) in
                let state = MovieCollectionViewState.hasLoaded(data: movies, error: nil)
                self?.userInterface?.render(state: state)
            }, onError: { [weak self] (error) in
                let state = MovieCollectionViewState.hasLoaded(data: nil, error: error)
                self?.userInterface?.render(state: state)
            }).disposed(by: disposeBag)
    }
}
