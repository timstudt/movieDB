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

//    func testConnector() {
//        let mockConnector = MockConnector()
//        networkService.networkProvider = mockConnector
//        XCTAssertNotNil(networkService.networkProvider, "")
//        XCTAssertFalse(mockConnector.didCallSendData, "")
//        networkService.fetch { (data, error) in
//
//        }
//        XCTAssertTrue(mockConnector.didCallSendData, "")
//    }

    // MARK: - integration tests
    func testConnector() {
        networkService = MovieNetworkService.networkService()
        XCTAssertNotNil(networkService.networkProvider, "")
        let expectation = XCTestExpectation(description: "Fetch movies using url session")
        networkService.fetch { (data, error) in
            // Make sure we downloaded some data.
            XCTAssertNotNil(data, "No data was downloaded.")
            
            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 4.0)
    }
    
    func testConnectorAlamofire() {
        networkService = MovieNetworkService.networkService()
        networkService.networkProvider = AlamofireConnector()
        XCTAssertNotNil(networkService.networkProvider, "")
        let expectation = XCTestExpectation(description: "Fetch movies using url session")
        networkService.fetch { (data, error) in
            // Make sure we downloaded some data.
            XCTAssertNotNil(data, "No data was downloaded.")
            
            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 4.0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
