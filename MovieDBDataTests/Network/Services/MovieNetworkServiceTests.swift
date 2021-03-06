//
//  MovieNetworkServiceTests.swift
//  MovieDBDataTests
//
//  Created by Tim Studt on 02/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import XCTest

//swiftlint:disable file_length
//swiftlint:disable file_types_order
//swiftlint:disable force_unwrapping
class MovieNetworkServiceTests: XCTestCase {
    typealias SUT = MovieNetworkService

    var networkService: SUT!

    // MARK: - dependencies

    private var connector: NetworkProvider!//AlamofireConnector()
    private var defaultSerializer: Serializable!
    private var api: MovieDBNetwork.APIClient!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        networkService = nil
        connector = nil
        defaultSerializer = nil
        api = nil
        super.tearDown()
    }

    func testDefaultInit() {
        networkService = SUT(
            defaultSerializer: defaultSerializer,
            networkProvider: connector,
            api: api
        )
        XCTAssertNil(networkService.networkProvider)
        XCTAssertNil(networkService.api)
        XCTAssertNil(networkService.defaultSerializer)
    }

    func testFactoryInit() {
        networkService = SUT.makeNetworkService()
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

    func testInvalidQuery() {
        networkService = SUT.makeNetworkService()

        let expectation = XCTestExpectation(description: "invalid query")
        let task = networkService.search(query: "") { (data, error) in
            XCTAssertNil(data, "data should be nil. \(error!)")
            XCTAssertEqual(error as? MovieNetworkService.Error, MovieNetworkService.Error.invalidQuery, "error should be .invalidQuery. got \(error!)")

            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
        }

        XCTAssertNil(task, "task should be nil")

        wait(for: [expectation], timeout: 4.0)
    }
    
    // MARK: - integration tests
    func testConnector() {
        networkService = SUT.makeNetworkService()
        XCTAssertNotNil(networkService.networkProvider, "")
        let expectation = XCTestExpectation(description: "Fetch movies using url session")
        let task = networkService.search(query: "h") { (data, error) in
            // Make sure we downloaded some data.
            XCTAssertNotNil(data, "No data was downloaded. \(error!)")

            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
        }

        XCTAssertNotNil(task, "task should not be nil")

        wait(for: [expectation], timeout: 4.0)
    }

    func testConnectorAlamofire() {
        connector = URLSessionConnector()//AlamofireConnector()
        defaultSerializer = MovieDBNetwork.Serializer()
        api = MovieDBNetwork.APIClient()
        setupSUT()
        XCTAssertNotNil(networkService.networkProvider, "")
        let expectation = XCTestExpectation(description: "Fetch movies using url session")
        let task = networkService.search(query: "h") { (data, error) in
            // Make sure we downloaded some data.
            XCTAssertNotNil(data, "No data was downloaded. \(error!)")

            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
        }

        XCTAssertNotNil(task, "task should not be nil")

        wait(for: [expectation], timeout: 4.0)

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    private func setupSUT() {
        networkService = SUT(
            defaultSerializer: defaultSerializer,
            networkProvider: connector,
            api: api
        )
    }
}
