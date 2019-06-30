import Foundation

@available(*, deprecated, message: "use Swift.Result instead")
public enum Result<T> {
    case success(T)
    case failure(Error)

    public init(_ value: T) {
        self = .success(value)
    }

    public init(_ error: Error) {
        self = .failure(error)
    }

    public var failed: Bool {
        switch self {
        case .failure: return true
        case .success: return false
        }
    }

    public var succeded: Bool {
        return !failed
    }

    public var error: Error? {
        switch self {
        case .failure(let error):
            return error
        case .success:
            return nil
        }
    }

    public var value: T? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }

    public func map<U>(_ transform: (T) -> U) -> Result<U> {
        switch self {
        case .failure(let error): return .failure(error)
        case .success(let value): return .success(transform(value))
        }
    }

    public func bind<U>(_ fun: (T) -> Result<U>) -> Result<U> {
        switch self {
        case .failure(let error): return .failure(error)
        case .success(let value): return fun(value)
        }
    }
}
