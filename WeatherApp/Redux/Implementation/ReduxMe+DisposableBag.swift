//
//  DisposableBag.swift
//  ReduxMe
//
//  Created by Ilias Pavlidakis on 3/5/19.
//  Copyright © 2019 ReduxMe All rights reserved.
//

import Foundation

public extension ReduxMe {

    final class DisposableBag {

        private var disposableElements: [ReduxMeDisposable] = []

        public init() {}

        deinit {

            disposableElements.forEach { $0.onDispose() }
        }
    }
}

extension ReduxMe.DisposableBag: ReduxMeDisposableBagProtocol {

    public func add(
        _ element: ReduxMeDisposable) {

        disposableElements.append(element)
    }
}
