//
//  URLBuilderTests.swift
//  MovieDBDataTests
//
//  Created by Tim Studt on 07/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import XCTest

// swiftlint:disable force_unwrapping
// swiftlint:disable force_try

class URLBuilderTests: XCTestCase {

    var builder: URLBuilder!
    let testURL = URL(string: "www.gmx.net")!

    override func setUp() {
        super.setUp()
        builder = try! URLBuilder(baseURL: testURL)
    }

    override func tearDown() {
        builder = nil
        super.tearDown()
    }

    func testInit() {
        XCTAssertNotNil(try! builder.build(), "unexpected return nil")
        XCTAssertEqual(try! builder.build(), testURL, "unexpected url returned")
    }

    func testPath() {
        builder.add(path: "hello")
        //swiftlint:disable force_unwrapping
        let expectedURL = URL(string: "\(testURL.absoluteURL)/hello")!
        XCTAssertEqual(try! builder.build(), expectedURL, "unexpected url returned")
    }

    func testQuery() {
        builder.add(queries: [URLQueryItem(name: "query", value: "hello")])
        let expectedURL = URL(string: "\(testURL.absoluteURL)?query=hello")!
        XCTAssertEqual(try! builder.build(), expectedURL, "unexpected url returned")
    }

    func testQueries() {
        builder.add(queries: [URLQueryItem(name: "query", value: "hello")])
        builder.add(queries: [URLQueryItem(name: "name", value: "tim")])
        let expectedURL = URL(string: "\(testURL.absoluteURL)?query=hello&name=tim")!
        XCTAssertEqual(try! builder.build(), expectedURL, "unexpected url returned")
    }

    func testPAthAndQuery() {
        builder.add(queries: [URLQueryItem(name: "query", value: "hello")])
        builder.add(path: "hello")
        let expectedURL = URL(string: "\(testURL.absoluteURL)/hello?query=hello")!
        XCTAssertEqual(try! builder.build(), expectedURL, "unexpected url returned")
    }

    func testURLBuilderPerformance() {
        self.measure {
            builder.add(queries: [URLQueryItem(name: "query", value: "hello")])
            builder.add(queries: [URLQueryItem(name: "name", value: "tim")])
            builder.add(path: "hello")
            _ = try! builder.build()
        }
    }

}
