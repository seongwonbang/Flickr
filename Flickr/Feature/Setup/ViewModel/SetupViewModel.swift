//
//  SetupViewModel.swift
//  Flickr
//
//  Created by 방성원 on 2018. 5. 8..
//  Copyright © 2018년 makesource. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SetupViewModel {
    let dependency: AppDependency

    // inputs
    let upButtonTapped = PublishSubject<Void>()
    let downButtonTapped = PublishSubject<Void>()
    let startButtonTapped = PublishSubject<Void>()

    // outputs
    let intervalTime: Driver<Int>
    let photoViewModel: Signal<PhotoViewModel>

    init(dependency: AppDependency) {
        self.dependency = dependency

        let upValue = upButtonTapped.map { 1 }
        let downValue = downButtonTapped.map { -1 }

        intervalTime = Observable.merge([upValue, downValue])
            .scanInRange(1, low: 1, high: 10) { $0 + $1 }
            .startWith(1)
            .asDriver(onErrorJustReturn: 1)

        photoViewModel = startButtonTapped
            .withLatestFrom(intervalTime) { $1 }
            .map { dependency.photoViewModel(interval: $0) }
            .asSignal(onErrorRecover: { _ in .empty() })
    }
}

extension ObservableType where E == Int {
    public func scanInRange<A: Comparable>(_ seed: A, low: A, high: A, accumulator: @escaping (A, Self.E) throws -> A) -> Observable<A> {
        let acc = { (x: A, y: Self.E) throws -> A in
            let z = try accumulator(x, y)
            if (z < low) { return low }
            else if (z > high) { return high }
            else { return z }
        }
        return self.scan(seed, accumulator: acc)
    }
}
