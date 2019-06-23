// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable file_length
// swiftlint:disable variable_name

import Foundation
import RxSwift
@testable import MovieDB

// MARK: - MovieDBAPI

class MovieDBAPIMock: MovieDBAPI {
    var APIKey: String {
        get { return underlyingAPIKey }
        set(value) { underlyingAPIKey = value }
    }
    var underlyingAPIKey: String!
    var baseURL: URL {
        get { return underlyingBaseURL }
        set(value) { underlyingBaseURL = value }
    }
    var underlyingBaseURL: URL!
    var cachePolicy: URLRequest.CachePolicy {
        get { return underlyingCachePolicy }
        set(value) { underlyingCachePolicy = value }
    }
    var underlyingCachePolicy: URLRequest.CachePolicy!
    var timeoutInterval: TimeInterval {
        get { return underlyingTimeoutInterval }
        set(value) { underlyingTimeoutInterval = value }
    }
    var underlyingTimeoutInterval: TimeInterval!
    var allHTTPHeaderFields: [String: String] = [:]

    //MARK: - buildRequest

    struct BuildRequestUrlHttpMethod {
      var callsCount = 0
      var called: Bool { return callsCount > 0 }
      var receivedArguments: (url: URL, httpMethod: HTTPMethod)?
      var returnValue: URLRequest!
    }

    var buildRequestUrlHttpMethodClosure: ((URL, HTTPMethod) -> URLRequest)?

    var _buildRequestUrlHttpMethod = BuildRequestUrlHttpMethod()

    func buildRequest(url: URL, httpMethod: HTTPMethod) -> URLRequest {
        _buildRequestUrlHttpMethod.callsCount += 1
        _buildRequestUrlHttpMethod.receivedArguments = (url: url, httpMethod: httpMethod)
        return buildRequestUrlHttpMethodClosure.map({ $0(url, httpMethod) }) ?? _buildRequestUrlHttpMethod.returnValue
    }
}
// MARK: - MovieService

class MovieServiceMock: MovieService {

    //MARK: - fetch

    struct FetchCompletion {
      var callsCount = 0
      var called: Bool { return callsCount > 0 }
      var receivedCompletion: ((DataProviderResponse<[MovieModel]>) -> Void)?
    }

    var fetchCompletionClosure: ((((DataProviderResponse<[MovieModel]>) -> Void)?) -> Void)?

    var _fetchCompletion = FetchCompletion()

    func fetch(completion: ((DataProviderResponse<[MovieModel]>) -> Void)?) {
        _fetchCompletion.callsCount += 1
        _fetchCompletion.receivedCompletion = completion
        fetchCompletionClosure?(completion)
    }

    //MARK: - fetch

    struct FetchIdCompletion {
      var callsCount = 0
      var called: Bool { return callsCount > 0 }
      var receivedArguments: (id: Int, completion: ((DataProviderResponse<MovieModel>) -> Void)?)?
    }

    var fetchIdCompletionClosure: ((Int, ((DataProviderResponse<MovieModel>) -> Void)?) -> Void)?

    var _fetchIdCompletion = FetchIdCompletion()

    func fetch(id: Int, completion: ((DataProviderResponse<MovieModel>) -> Void)?) {
        _fetchIdCompletion.callsCount += 1
        _fetchIdCompletion.receivedArguments = (id: id, completion: completion)
        fetchIdCompletionClosure?(id, completion)
    }

    //MARK: - search

    struct SearchQueryCompletion {
      var callsCount = 0
      var called: Bool { return callsCount > 0 }
      var receivedArguments: (query: String?, completion: ((DataProviderResponse<[MovieModel]>) -> Void)?)?
    }

    var searchQueryCompletionClosure: ((String?, ((DataProviderResponse<[MovieModel]>) -> Void)?) -> Void)?

    var _searchQueryCompletion = SearchQueryCompletion()

    func search(query: String?, completion: ((DataProviderResponse<[MovieModel]>) -> Void)?) {
        _searchQueryCompletion.callsCount += 1
        _searchQueryCompletion.receivedArguments = (query: query, completion: completion)
        searchQueryCompletionClosure?(query, completion)
    }
}
// MARK: - NetworkTask

class NetworkTaskMock: NetworkTask {

    //MARK: - cancel

    struct Cancel {
      var callsCount = 0
      var called: Bool { return callsCount > 0 }
    }

    var cancelClosure: (() -> Void)?

    var _cancel = Cancel()

    func cancel() {
        _cancel.callsCount += 1
        cancelClosure?()
    }

    //MARK: - resume

    struct Resume {
      var callsCount = 0
      var called: Bool { return callsCount > 0 }
    }

    var resumeClosure: (() -> Void)?

    var _resume = Resume()

    func resume() {
        _resume.callsCount += 1
        resumeClosure?()
    }

    //MARK: - suspend

    struct Suspend {
      var callsCount = 0
      var called: Bool { return callsCount > 0 }
    }

    var suspendClosure: (() -> Void)?

    var _suspend = Suspend()

    func suspend() {
        _suspend.callsCount += 1
        suspendClosure?()
    }
}
