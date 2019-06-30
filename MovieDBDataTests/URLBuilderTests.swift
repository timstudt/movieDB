//
//  URLBuilderTests.swift
//  MovieDBDataTests
//
//  Created by Tim Studt on 07/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import XCTest

class URLBuilderTests: XCTestCase {

    var builder: URLBuilder!
    let testURL = URL(string: "www.gmx.net")!

    override func setUp() {
        super.setUp()
        builder = URLBuilder(baseURL: testURL)
    }

    override func tearDown() {
        builder = nil
        super.tearDown()
    }

    func testInit() {
        XCTAssertNotNil(builder.build(), "unexpected return nil")
        XCTAssertEqual(builder.build(), testURL, "unexpected url returned")
    }

    func testPath() {
        builder.add(path: "hello")
        //swiftlint:disable force_unwrapping
        let expectedURL = URL(string: "\(testURL.absoluteURL)/hello")!
        XCTAssertEqual(builder.build(), expectedURL, "unexpected url returned")
    }

    func testQuery() {
        builder.add(queries: [URLQueryItem(name: "query", value: "hello")])
        let expectedURL = URL(string: "\(testURL.absoluteURL)?query=hello")!
        XCTAssertEqual(builder.build(), expectedURL, "unexpected url returned")
    }

    func testQueries() {
        builder.add(queries: [URLQueryItem(name: "query", value: "hello")])
        builder.add(queries: [URLQueryItem(name: "name", value: "tim")])
        let expectedURL = URL(string: "\(testURL.absoluteURL)?query=hello&name=tim")!
        XCTAssertEqual(builder.build(), expectedURL, "unexpected url returned")
    }

    func testPAthAndQuery() {
        builder.add(queries: [URLQueryItem(name: "query", value: "hello")])
        builder.add(path: "hello")
        let expectedURL = URL(string: "\(testURL.absoluteURL)/hello?query=hello")!
        XCTAssertEqual(builder.build(), expectedURL, "unexpected url returned")
    }

    func testURLBuilderPerformance() {
        self.measure {
            builder.add(queries: [URLQueryItem(name: "query", value: "hello")])
            builder.add(queries: [URLQueryItem(name: "name", value: "tim")])
            builder.add(path: "hello")
            _ = builder.build()
        }
    }

}
