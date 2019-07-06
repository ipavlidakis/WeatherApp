//
//  ReduxMeStub+DisposeBag.swift
//  ReduxMe Tests
//
//  Created by Ilias Pavlidakis on 01/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
@testable import WeatherApp

extension ReduxMe.Stub {

    final class DisposeBag {

        private(set) var elements: [ReduxMeDisposable] = []
    }
}

extension ReduxMe.Stub.DisposeBag: ReduxMeDisposableBagProtocol {

    func add(_ element: ReduxMeDisposable) {

        elements.append(element)
    }
}
