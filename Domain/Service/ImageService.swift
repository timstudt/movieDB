//
//  ImageService.swift
//  MovieDB
//
//  Created by Tim Studt on 10/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import Foundation

protocol ImageService {
    func downloadImage(relativePath: String, completion: ((DataProviderResponse<Data>) -> Void)?)
}
