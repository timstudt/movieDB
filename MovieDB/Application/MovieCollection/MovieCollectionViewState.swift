//
//  MovieCollectionViewState.swift
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

final class MovieCollectionViewState: ViewState<[MovieModel]> {
    static func loading() -> MovieCollectionViewState {
        return MovieCollectionViewState(isLoading: true, error: nil, data: nil)
    }

    static func hasLoaded(data: [MovieModel]?, error: Error?) -> MovieCollectionViewState {
        return MovieCollectionViewState(isLoading: false, error: error, data: data)
    }
}
