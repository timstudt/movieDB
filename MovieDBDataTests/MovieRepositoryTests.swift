//
//  MovieRepositoryTests.swift
//  MovieDBDataTests
//
//  Created by Tim Studt on 01/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import XCTest

private struct MockAPI: API {
    var baseURL: URL { return URL(string: "http://www.google.com")! }
}

extension MovieModel {
    static var batman: MovieModel {
        return MovieModel(id: 1, name: "Batman", caption: "relklfs dlfkdlfk", imageURL: nil)
    }
    static var superman: MovieModel {
        return MovieModel(id: 2, name: "Superman", caption: nil, imageURL: nil)
    }
    static var spiderman: MovieModel {
        return MovieModel(id: 3, name: "Spiderman", caption: "dl dlfkdlfk", imageURL: nil)
    }
}

struct TestDataSource {
    func videos() -> [MovieModel]? {
        let videos: [MovieModel] = [.batman, .spiderman, .superman]//test
        return videos
    }

    func error() -> Error? {
        return nil
    }
}

private class MockMovieNetworkService: NetworkService<MockAPI>, MovieDataProvider {
    let testDataSource = TestDataSource()

    var didCallFetch = false
    var didCallFetchID = false
    var didCallSearch = false

    func fetch(completion: ((DataProviderResponse<[MovieModel]>) -> Void)?) {
        didCallFetch = true
        completion?((testDataSource.videos(), testDataSource.error()))
    }
    func fetch(id: Int, completion: ((DataProviderResponse<MovieModel>) -> Void)?) {
        didCallFetchID = true
    }
    func search(query: String?, completion: ((DataProviderResponse<[MovieModel]>) -> Void)?) {
        didCallSearch = true
    }
}

class MockNetworkTask: NetworkTask {
    func cancel() { }
    func resume() { }
    func suspend() { }
}

class MockConnector: NetworkProvider {
    var logger: NetworkLoggable?
    var didCallSendData = false
    var didCallSendArray = false

    func send(request: URLRequest,
              completion: @escaping (((Data?, Error?)) -> Void))
        -> NetworkTask {
        didCallSendData = true
        completion((nil, nil))
        return MockNetworkTask()
    }
    func send<T>(request: URLRequest,
                 serializer: Serializable?,
                 completion: @escaping ((([T]?, Error?)) -> Void))
        -> NetworkTask where T: Decodable {
        didCallSendData = false
        completion((nil, nil))
        return MockNetworkTask()
    }
}

class MovieRepositoryTests: XCTestCase {
    var repository: MovieRepository!
    fileprivate let testService = MockMovieNetworkService(networkProvider: nil, api: nil)

    override func setUp() {
        super.setUp()
        repository = MovieRepository()
    }

    override func tearDown() {
        repository = nil
        super.tearDown()
    }

    func testDefaultInit() {
        XCTAssertNil(repository.networkService)
        XCTAssertNil(repository.cache)
    }

    func testNetworkService() {
        repository.networkService = testService

        XCTAssertFalse(testService.didCallFetch, "unexpected fetch call")
        XCTAssertFalse(testService.didCallFetchID, "unexpected fetchID call")
        XCTAssertFalse(testService.didCallSearch, "unexpected search call")

        repository.loadData { (response) in
            XCTAssertNotNil(response, "invalid response")
            XCTAssertNil(response.1, "load data unexpected error in response")
            let data = response.0
            XCTAssertNotNil(data)
            XCTAssert(data! == TestDataSource().videos()!, "load data unexpected data returned")
        }
        XCTAssertTrue(testService.didCallFetch, "expected fetch call")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
