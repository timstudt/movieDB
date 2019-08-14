//
//  ImageNetworkServiceTests.swift
//  MovieDBDataTests
//
//  Created by Tim Studt on 02/05/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import XCTest

class ImageNetworkServiceTests: XCTestCase {

    var networkService: ImageNetworkService!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        networkService = nil
        super.tearDown()
    }

    func testDefaultInit() {
        networkService = ImageNetworkService(networkProvider: nil, api: nil)
        XCTAssertNil(networkService.networkProvider)
        XCTAssertNil(networkService.api)
    }

    func testFactoryInit() {
        networkService = ImageNetworkService.networkService()
        XCTAssertNotNil(networkService.networkProvider)
        XCTAssertNotNil(networkService.api)
    }

    func testConnectorNoAPI() {
        let connector = MockConnector()
        networkService = ImageNetworkService(networkProvider: connector, api: nil)

        XCTAssertNil(networkService.api)
        XCTAssertNotNil(networkService.networkProvider, "")
        XCTAssertFalse(connector.didCallDownloadData, "unexpected download called")
        networkService.downloadImage(relativePath: "hello") { (data, error) in
            XCTAssertNil(data, "load data unexpected error in response")
            XCTAssertNil(error)
        }
        XCTAssertFalse(connector.didCallDownloadData, "unexpected download not called")
    }

    func testConnectorAPI() {
        let connector = MockConnector()
        networkService = ImageNetworkService(networkProvider: connector, api: MovieDBNetwork.APIClient()) // TODO use mock instead
        XCTAssertNotNil(networkService.api)
        XCTAssertNotNil(networkService.networkProvider, "")
        XCTAssertFalse(connector.didCallDownloadData, "unexpected download called")
        networkService.downloadImage(relativePath: "hello") { (data, error) in
            XCTAssertNil(data, "load data unexpected error in response")
            XCTAssertNil(error)
        }
        XCTAssertTrue(connector.didCallDownloadData, "unexpected download not called")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
