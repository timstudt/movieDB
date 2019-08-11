//
//  ViewStateTests.swift
//  videoplayerTests
//
//  Created by Tim Studt on 22/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import XCTest
@testable import MovieDB

final class ViewStateTests: XCTestCase {
    var viewState: ViewState<[String]>!

    override func setUp() {
        super.setUp()
        viewState = .init()
    }

    override func tearDown() {
        viewState = nil
        super.tearDown()
    }

    func testInit() {
        XCTAssert(viewState.isLoading == false, "loading state wrong")
        XCTAssert(viewState.data == nil, "loading state wrong")
        XCTAssert(viewState.error == nil, "loading state wrong")
    }

    func testLoading() {
        viewState.data = ["first", "second", "third"]
        XCTAssert(viewState.isLoading == false, "loading state wrong")
        XCTAssert(viewState.data?.count == 3, "data wrong")
        XCTAssert(viewState.error == nil, "error wrong")
    }
}
