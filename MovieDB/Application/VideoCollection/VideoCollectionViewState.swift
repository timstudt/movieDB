//
//  VideoCollectionViewState.swift
//  videoplayer
//
//  Created by Tim Studt on 13/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

final class VideoCollectionViewState: ViewState<MovieModel> {
    static func loading() -> VideoCollectionViewState {
        return VideoCollectionViewState(isLoading: true, error: nil, data: nil)
    }

    static func hasLoaded(data: [MovieModel]?, error: Error?) -> VideoCollectionViewState {
        return VideoCollectionViewState(isLoading: false, error: error, data: data)
    }
}
