//
//  VideoCollectionPresenter.swift
//  videoplayer
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation
import RxSwift

final class VideoCollectionPresenter: Presenter {
    typealias Response = Single<[MovieModel]>

    // MARK: - Module
    private let loadMovies: GetMovies.usecase
    private let disposeBag: DisposeBag
    private let notificationService: NotificationService
    
    init(
        loadMovies: @escaping GetMovies.usecase = GetMovies().execute,
        disposeBag: DisposeBag = .init(),
        notificationService: NotificationService = .init()) {
        self.loadMovies = loadMovies
        self.disposeBag = disposeBag
        self.notificationService = notificationService
    }
    
    // MARK: - ViewDataSource
    override func loadData() {
        loadMovies()
            .subscribe(onSuccess: { [weak self] (movies) in
                let state = VideoCollectionViewState.hasLoaded(data: movies, error: nil)
                self?.userInterface?.render(state: state)
            }, onError: { [weak self] (error) in
                let state = VideoCollectionViewState.hasLoaded(data: nil, error: error)
                self?.userInterface?.render(state: state)
            }).disposed(by: disposeBag)
        sendTestNotifications()
    }

    // MARK: - private methods
    
    private func sendTestNotifications() {
        notificationService.requestPermission { [weak self] (granted) in
            self?.notificationService.sendTestNotifications()
        }
    }
}
