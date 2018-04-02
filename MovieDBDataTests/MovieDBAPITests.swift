//
//  MovieDBAPITests.swift
//  MovieDBTests
//
//  Created by Tim Studt on 31/03/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import XCTest
@testable import MovieDB

class MovieDBAPITests: XCTestCase {
    let testKey = "123456"
    let testURL = URL(string: "www.google.com")!
    var apiClient: MovieDBNetwork.APIClient!
    var apiConfig: MovieDBNetwork.Configuration!

    override func setUp() {
        super.setUp()
        apiConfig = MovieDBNetwork.Configuration.init(APIKey: testKey, baseURL: testURL)
        apiClient = MovieDBNetwork.APIClient.init(configuration: apiConfig)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        apiConfig = nil
        apiClient = nil
        super.tearDown()
    }

    func testDefaultConfig() {
        let defaultAPIClient = MovieDBNetwork.APIClient()
        XCTAssert(defaultAPIClient.APIKey == MovieDBNetwork.Configuration.defaultAPIKey, "invalid api key init")
        XCTAssert(defaultAPIClient.baseURL == MovieDBNetwork.Configuration.defaultBaseURL, "invalid base URL init")
    }

    func testConfig() {
        XCTAssert(apiConfig.APIKey == testKey, "invalid api key init")
        XCTAssert(apiConfig.baseURL == testURL, "invalid base URL init")
    }

    func testClientInit() {
        XCTAssert(apiClient.APIKey == testKey, "invalid api key init")
        XCTAssert(apiClient.baseURL == testURL, "invalid base URL init")
    }

    func testRequests() {
        let GETMethod = "GET"
        let request = apiClient.buildRequest(url: testURL, httpMethod: GETMethod)

        XCTAssert(request.httpMethod == GETMethod, "")
        XCTAssert(request.url == testURL, "")
    }

    func testSearchMoviesRequests() {
        let queryString = "test"
        let query = [
            "query=\(queryString)",
            "api_key=\(MovieDBNetwork.Configuration.defaultAPIKey)"
            ].joined(separator: "&")

        let request = MovieDBNetwork.APIClient().searchMovie(query: queryString)

        XCTAssert(request.httpMethod == "GET", "wrong http method")

        let url = request.url
        XCTAssert(url?.scheme == "https", "wrong url scheme")
        XCTAssert(url?.host == "api.themoviedb.org", "wrong url host")
        XCTAssert(url?.path == "/3/search/movie", "wrong url path")
        XCTAssert(url?.query == query, "wrong url query")

        XCTAssertNotNil(request.url?.absoluteString, "invalid url")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
