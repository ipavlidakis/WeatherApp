//
//  ReduxMeStub+SerialDispatchQueue.swift
//  ReduxMe Tests
//
//  Created by Ilias Pavlidakis on 01/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
@testable import WeatherApp

extension ReduxMe.Stub {

    final class SerialDispatchQueue {

        var enqueueWasCalledWithBlock: (() -> Void)?
        var clearWasCalled: Bool = false
    }
}

extension ReduxMe.Stub.SerialDispatchQueue: ReduxMeSerialDispatchQueueing {

    func enqueue(_ block: @escaping () -> Void) {

        enqueueWasCalledWithBlock = block
        block()
    }

    func clear() {

        clearWasCalled = true
    }
}
