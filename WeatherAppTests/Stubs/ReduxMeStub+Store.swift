//
//  RTUStubRESReduxStore.swift
//  Reservations-Framework-Tests
//
//  Created by Ilias Pavlidakis on 1/18/19.
//  Copyright © 2019 Expedia, INC. All rights reserved.
//

import Foundation
@testable import WeatherApp

extension ReduxMe.Stub {

    final class Store: ReduxMe.Store<ReduxMe.Stub.State> {

        var stubState: State!

        private(set) var dispatchWasCalledWithActions: [ReduxMeActionProtocol] = []

        var subscribeWasCalledWithListeners: [ReduxMeListenerProtocol] = []
        var subscribeWasCalledWithMiddleware: [ReduxMeMiddlewareProtocol] = []
        var unsubscribeStubResult: ReduxMe.UnsubscribeListener = {}

        convenience init(
            stubState: ReduxMe.Stub.State = .initial,
            reducers: [ReduxMeReducerProtocol] = [],
            middleware: [ReduxMeMiddlewareProtocol] = [],
            listeners: [ReduxMeListenerProtocol] = [],
            serialActionDispatchQueue: ReduxMe.Stub.SerialDispatchQueue = ReduxMe.Stub.SerialDispatchQueue(),
            mainThreadDispatcher: ReduxMe.Stub.Dispatch = ReduxMe.Stub.Dispatch()) {

            self.init(
                state: stubState,
                reducers: reducers,
                middleware: middleware,
                listeners: listeners,
                serialActionDispatchQueue: serialActionDispatchQueue,
                mainThreadDispatcher: mainThreadDispatcher)

            self.stubState = stubState
        }

        override var state: State {

            return stubState
        }

        override func subscribe(
            _ listener: ReduxMeListenerProtocol) -> ReduxMe.UnsubscribeListener {

            subscribeWasCalledWithListeners.append(listener)

            return unsubscribeStubResult
        }

        override func subscribe(
            _ middleware: ReduxMeMiddlewareProtocol) {

            subscribeWasCalledWithMiddleware.append(middleware)
        }

        override func dispatch(
            _ action: ReduxMeActionProtocol) {

            dispatchWasCalledWithActions.append(action)
        }
    }
}

extension ReduxMe.Stub.Store {

    func triggerStateChangeForListeners() {

        subscribeWasCalledWithListeners.forEach { subscriber in

            subscriber.stateUpdated()
        }
    }
}
