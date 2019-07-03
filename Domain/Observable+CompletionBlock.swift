import Foundation
import RxSwift

extension Observable {
    public static func from(completionBasedFunction execute: @escaping (@escaping (Result<Element>) -> Void) -> Void) -> Observable<Element> {
        return Observable.create { observer in
            execute { result in
                switch result {
                case .success(let element):
                    observer.onNext(element)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
