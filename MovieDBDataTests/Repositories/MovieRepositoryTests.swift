//
//  MovieRepositoryTests.swift
//  MovieDBDataTests
//
//  Created by Tim Studt on 01/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import XCTest
import RxBlocking

//swiftlint:disable file_length
//swiftlint:disable file_types_order
struct MockAPI: API {
    //swiftlint:disable force_unwrapping
    var baseURL: URL { return URL(string: "http://www.google.com")! }
}

// Test Data
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
        return NetworkTaskMock()
    }
    func send<T>(request: URLRequest,
                 serializer: Serializable?,
                 completion: @escaping (((data: [T]?, error: Error?)) -> Void))
        -> NetworkTask where T: Decodable {
        didCallSendData = true
        completion((nil, nil))
        return NetworkTaskMock()
    }
    func download(request: URLRequest,
                  progress: @escaping (Progress) -> Void,
                  completion: @escaping ((data: Data?, error: Error?)) -> Void)
        -> NetworkTask {
        didCallDownloadData = true
        completion((nil, nil))
        return NetworkTaskMock()
    }
}

class MovieRepositoryTests: XCTestCase {
    var sut: MovieRepository!

    // MARK: - Dependencies

    fileprivate var networkService: MovieServiceMock!
    fileprivate var cache: MovieServiceMock!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        networkService = nil
        cache = nil
        super.tearDown()
    }

    func testDefaultInit() {
        sut = MovieRepository()
        XCTAssertNil(sut.networkService)
        XCTAssertNil(sut.cache)
    }

    func testRepositoryFactoryMethod() {
        sut = MovieRepository.makeRepository()
        XCTAssertNotNil(sut.networkService, "unexpected cache found")
        XCTAssertNil(sut.cache, "unexpected cache found")
    }

    func testNetworkService() {
        networkService = MovieServiceMock()
        networkService.searchQueryCompletionClosure = { (query, response) in
            let testDataSource = TestDataSource()
            response?((testDataSource.videos(), testDataSource.error()))
            return NetworkTaskMock()
        }
        setupSUT()

        XCTAssertFalse(networkService._fetchIdCompletion.called, "unexpected fetchID call")
        XCTAssertFalse(networkService._searchQueryCompletion.called, "unexpected search call")

        let expectation = self.expectation(description: "search movies")
        var response: DataProviderResponse<[MovieModel]>!
        let task = sut.searchMovies(query: "test") { resp in
            response = resp
            expectation.fulfill()
        }

        XCTAssertNotNil(task, "task should not be nil")

        waitForExpectations(timeout: 5)
        XCTAssertNotNil(response.0, "invalid response")
        XCTAssertNil(response.1)
        //swiftlint:disable force_unwrapping
        XCTAssert(response.0! == TestDataSource().videos()!, "load data unexpected data returned")
        XCTAssertTrue(networkService._searchQueryCompletion.called, "expected fetch call")
    }
}

extension MovieRepositoryTests {
    func testNetworkServiceRx() {
        networkService = MovieServiceMock()
        networkService.searchQueryCompletionClosure = { (query, response) in
            let testDataSource = TestDataSource()
            response?((testDataSource.videos(), testDataSource.error()))
            return NetworkTaskMock()
        }
        setupSUT()

        XCTAssertFalse(networkService._fetchIdCompletion.called, "unexpected fetchID call")
        XCTAssertFalse(networkService._searchQueryCompletion.called, "unexpected search call")

        XCTAssertNoThrow(try sut.searchMovies().toBlocking().single(), "")
        let result = try? sut.searchMovies(query: "test").toBlocking().single()
        XCTAssertNotNil(result, "invalid response")
        XCTAssertNotNil(result)
        //swiftlint:disable force_unwrapping
        XCTAssert(result! == TestDataSource().videos()!, "load data unexpected data returned")
        XCTAssertTrue(networkService._searchQueryCompletion.called, "expected fetch call")
    }

    func testCacheRx() {
        cache = MovieServiceMock()
        cache.searchQueryCompletionClosure = { (query, response) in
            let testDataSource = TestDataSource()
            response?((testDataSource.videos(), testDataSource.error()))
            return NetworkTaskMock()
        }
        setupSUT()

        XCTAssertFalse(cache._fetchIdCompletion.called, "unexpected fetchID call")
        XCTAssertFalse(cache._searchQueryCompletion.called, "unexpected search call")

        XCTAssertNoThrow(try sut.searchMovies().toBlocking().single(), "")
        let result = try? sut.searchMovies(query: "test").toBlocking().single()
        XCTAssertNotNil(result, "invalid response")
        //swiftlint:disable force_unwrapping
        XCTAssert(result == TestDataSource().videos()!, "load data unexpected data returned")
        XCTAssertTrue(cache._searchQueryCompletion.called, "expected fetch call")
    }

    private func setupSUT() {
        sut = MovieRepository(networkService: networkService,
                              dataBaseService: cache)
    }

}
