//
//  RTUStubRESDisposable.swift
//  Reservations-Framework-Tests
//
//  Created by Ilias Pavlidakis on 3/5/19.
//  Copyright © 2019 Expedia, INC. All rights reserved.
//

import Foundation
@testable import WeatherApp

extension ReduxMe.Stub {

    final class Disposable {

        private(set) var onDisposeWasCalled: Bool?
    }
}

extension ReduxMe.Stub.Disposable: ReduxMeDisposable {

    func onDispose() {

        onDisposeWasCalled = true
    }
}
