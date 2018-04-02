//
//  MovieNetworkServiceTests.swift
//  MovieDBDataTests
//
//  Created by Tim Studt on 02/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import XCTest

class MovieNetworkServiceTests: XCTestCase {
    var networkService: MovieNetworkService!
    
    override func setUp() {
        super.setUp()
        networkService = MovieNetworkService(networkProvider: nil, api: nil)
    }
    
    override func tearDown() {
        networkService = nil
        super.tearDown()
    }
    
    func testDefaultInit() {
        XCTAssertNil(networkService.networkProvider)
        XCTAssertNil(networkService.api)
        XCTAssertNil(networkService.defaultSerializer)
    }
    
    func testFactoryInit() {
        networkService = MovieNetworkService.networkService()
        XCTAssertNotNil(networkService.networkProvider)
        XCTAssertNotNil(networkService.api)
        XCTAssertNotNil(networkService.defaultSerializer)
    }
    
    func testConnector() {
        networkService.networkProvider = MockConnector()
        XCTAssertNotNil(networkService.networkProvider, "")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
