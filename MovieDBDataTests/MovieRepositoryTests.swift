//
//  MovieRepositoryTests.swift
//  MovieDBDataTests
//
//  Created by Tim Studt on 01/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import XCTest

struct MockAPI: API {
    var baseURL: URL { return URL(string: "http://www.google.com")! }
}

extension MovieModel {
    static var batman: MovieModel {
        return MovieModel(id: 1, name: "Batman", caption: "relklfs dlfkdlfk", imagePath: nil)
    }
    static var superman: MovieModel {
        return MovieModel(id: 2, name: "Superman", caption: nil, imagePath: nil)
    }
    static var spiderman: MovieModel {
        return MovieModel(id: 3, name: "Spiderman", caption: "dl dlfkdlfk", imagePath: nil)
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

class MockConnector: NetworkProvider, ImageDownloadRequestable {
    var logger: NetworkLoggable?
    var didCallSendData = false
    var didCallSendArray = false
    var didCallDownloadData = false
    
    func send(request: URLRequest,
              completion: @escaping (((data: Data?, error: Error?)) -> Void))
        -> NetworkTask {
        didCallSendData = true
        completion((nil, nil))
        return MockNetworkTask()
    }
    func send<T>(request: URLRequest,
                 serializer: Serializable?,
                 completion: @escaping (((data: [T]?, error: Error?)) -> Void))
        -> NetworkTask where T: Decodable {
        didCallSendData = true
        completion((nil, nil))
        return MockNetworkTask()
    }
    func download(request: URLRequest,
                  progress: @escaping (Progress) -> Void,
                  completion: @escaping ((data: Data?, error: Error?)) -> Void)
        -> NetworkTask {
        didCallDownloadData = true
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
            XCTAssertNil(response.error, "load data unexpected error in response")
            let data = response.data
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
