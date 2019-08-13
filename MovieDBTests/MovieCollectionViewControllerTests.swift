//
//  MovieCollectionViewControllerTests.swift
//  MovieDBTests
//
//  Created by Tim Studt on 30/07/2019.
//  Copyright © 2019 Tim Studt. All rights reserved.
//

import XCTest
@testable import MovieDB

class MovieCollectionViewControllerTests: XCTestCase {

    typealias SUT = MovieCollectionViewController

    var sut: SUT!
    var presenterMock: Presenter!
    var builderMock: ModuleBuilder!

    override func setUp() {
        super.setUp()
        presenterMock = MovieCollectionPresenter() // TODO: use a mock
        builderMock = ModuleBuilder() // TODO: use a mock
        sut = SUT.makeNewView(presenter: presenterMock, builder: builderMock) as? MovieCollectionViewController
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testFactory() {
        XCTAssertTrue(sut.dataSource is MovieCollectionPresenter)
    }
}
