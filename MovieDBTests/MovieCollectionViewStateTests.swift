//
//  MovieCollectionViewStateTests.swift
//  MovieDBTests
//
//  Created by Tim Studt on 12/08/2019.
//  Copyright © 2019 Tim Studt. All rights reserved.
//

import XCTest
@testable import MovieDB

final class MovieCollectionViewStateTests: XCTestCase {
    typealias SUT = MovieCollectionViewState

    var sut: SUT!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testInit() {
        sut = .init()
        XCTAssert(sut.isLoading == false, "loading state wrong")
        XCTAssert(sut.data == nil, "loading state wrong")
        XCTAssert(sut.error == nil, "loading state wrong")
    }

    func testLoadingFactory() {
        sut = SUT.loading()
        XCTAssert(sut.isLoading == true, "loading state wrong")
        XCTAssertNil(sut.data, "data wrong")
        XCTAssertNil(sut.error, "error wrong")
    }

    func testLoadedDataFactory() {
        let data = [MovieModel(id: 123, name: "movie", caption: nil, imagePath: nil)]
        sut = SUT.hasLoaded(data: data, error: nil)
        XCTAssert(sut.isLoading == false, "loading state wrong")
        XCTAssert(sut.data?.count == 1, "data wrong")
        XCTAssert(sut.error == nil, "error wrong")
    }
}
