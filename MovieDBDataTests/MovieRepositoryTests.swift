//
//  MovieRepositoryTests.swift
//  MovieDBDataTests
//
//  Created by Tim Studt on 01/04/2018.
//  Copyright © 2018 Tim Studt. All rights reserved.
//

import XCTest
import Alamofire

fileprivate struct MockAPI: API {
    var baseURL: URL { return URL(string: "http://www.google.com")! }
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

fileprivate class MockMovieNetworkService: NetworkService<MockAPI>, MovieDataProvider {
    let testDataSource = TestDataSource()
    
    func fetch(completion: ((DataProviderResponse<[MovieModel]>) -> Void)?) {
        completion?((testDataSource.videos(), testDataSource.error()))
    }
    func fetch(id: Int, completion: ((DataProviderResponse<MovieModel>)-> Void)?) {
    }
    func search(query: String?, completion: ((DataProviderResponse<[MovieModel]>) -> Void)?) {
    }
}

class MockConnector: NetworkProvider {
    func send(request: URLRequest, completion: (((Data?, Error?)) -> Void)?) {
        completion?((nil, nil))
    }
    func send<T>(request: URLRequest, serializer: Serializable?, completion: ((([T]?, Error?)) -> Void)?) where T : Decodable {
        completion?((nil, nil))
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
        XCTAssertNil(repository.dataBaseService)
    }
    
    func testNetworkService() {
        repository.networkService = testService
        repository.loadData { (response) in
            XCTAssertNotNil(response, "invalid response")
            XCTAssertNil(response.1, "load data unexpected error in response")
            let data = response.0
            XCTAssertNotNil(data)
            XCTAssert(data! == TestDataSource().videos()!, "load data unexpected data returned")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
