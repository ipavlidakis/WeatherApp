//
//  ReduxMeStub+Dispatcher.swift
//  ReduxMe Tests
//
//  Created by Ilias Pavlidakis on 01/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
@testable import WeatherApp

extension ReduxMe.Stub {

    final class Dispatch {

        private(set) var asyncWasCalled: Bool?
    }
}

extension ReduxMe.Stub.Dispatch: ReduxMeDispatching {

    func async(_ block: @escaping () -> Void) {

        asyncWasCalled = true

        block()
    }
}
