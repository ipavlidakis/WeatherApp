//
//  Store.swift
//  ReduxMe
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 ReduxMe All rights reserved.
//

import Foundation

extension ReduxMe {

    class Store<State: ReduxMeStateProtocol>: ReduxMeActionDispatching, ReduxMeStoreProtocol {

        private let reducer: ReduxMeReducerProtocol
        private let serialActionDispatchQueue: ReduxMeSerialDispatchQueueing
        private let mainThreadDispatcher: ReduxMeDispatching

        private var middleware: [ReduxMeMiddlewareProtocol]
        private var listeners: [ReduxMeListenerProtocol]

        private(set) open var state: State {
            didSet {
                mainThreadDispatcher.async {
                    [weak self] in

                    self?.listeners.forEach {
                        $0.stateUpdated()
                    }
                }
            }
        }

        init(
            state: State,
            reducers: [ReduxMeReducerProtocol],
            middleware: [ReduxMeMiddlewareProtocol] = [],
            listeners: [ReduxMeListenerProtocol] = [],
            serialActionDispatchQueue: ReduxMeSerialDispatchQueueing = ReduxMe.SerialDispatchQueue(),
            mainThreadDispatcher: ReduxMeDispatching = ReduxMe.Dispatcher(queue: .main)) {

            self.reducer = ReduxMe.CompoundReducer(reducers: reducers)
            self.middleware = middleware
            self.listeners = listeners
            self.serialActionDispatchQueue = serialActionDispatchQueue
            self.mainThreadDispatcher = mainThreadDispatcher

            self.state = state
        }

        func dispatch(_ action: ReduxMeActionProtocol) {

            serialActionDispatchQueue.enqueue { [weak self] in

                guard let self = self else { return }

                let initialState = self.state

                self.middleware.forEach { $0.apply(initialState, action) }

                self.state = self.reducer.reduce(initialState, action)
            }
        }

        func subscribe(
            _ listener: ReduxMeListenerProtocol) -> ReduxMe.UnsubscribeListener {

            listeners.append(listener)

            listener.stateUpdated()

            return { [weak self] in

                guard let self = `self` else { return }

                self.listeners = self.listeners
                    .filter { $0.identifier != listener.identifier }
            }
        }

        func subscribe(
            _ middleware: ReduxMeMiddlewareProtocol) {

            self.middleware.append(middleware)
        }
    }
}
