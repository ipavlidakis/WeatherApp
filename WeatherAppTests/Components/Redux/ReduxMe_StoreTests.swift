//
//  ReduxMe_StoreTests.swift
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 ReduxMe All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherApp

final class ReduxMe_StoreTests: XCTestCase {

    private var state: ReduxMe.Stub.State! = .initial
    private var stubReducers: [ReduxMe.Stub.Reducer]!
    private var stubMiddleware: [ReduxMe.Stub.Middleware]!
    private var stubListeners: [ReduxMe.Stub.Listener]!
    private var stubSerialActionDispatchQueue: ReduxMe.Stub.SerialDispatchQueue!
    private var stubMainThreadDispatcher: ReduxMe.Stub.Dispatch!

    private var store: ReduxMe.Store<ReduxMe.Stub.State>!
    
    override func setUp() {
        super.setUp()

        stubReducers = [ReduxMe.Stub.Reducer(), ReduxMe.Stub.Reducer()]
        stubMiddleware = [ReduxMe.Stub.Middleware(), ReduxMe.Stub.Middleware()]
        stubListeners = [ReduxMe.Stub.Listener(), ReduxMe.Stub.Listener()]
        stubSerialActionDispatchQueue = ReduxMe.Stub.SerialDispatchQueue()
        stubMainThreadDispatcher = ReduxMe.Stub.Dispatch()

        store = ReduxMe.Store<ReduxMe.Stub.State>(
            state: state,
            reducers: stubReducers,
            middleware: stubMiddleware,
            listeners: stubListeners,
            serialActionDispatchQueue: stubSerialActionDispatchQueue,
            mainThreadDispatcher: stubMainThreadDispatcher)
    }
    
    override func tearDown() {

        state = nil
        stubReducers = nil
        stubMiddleware = nil
        stubListeners = nil
        stubSerialActionDispatchQueue = nil
        stubMainThreadDispatcher = nil
        store = nil

        super.tearDown()
    }
}

extension ReduxMe_StoreTests {

    // MARK: - dispatch

    func test_dispatch_middlewareWereCalledWithExpectedValues() {

        let action = ReduxMe.Stub.Action()

        store.dispatch(action)
        
        stubMiddleware.forEach {
            
            XCTAssertEqual($0.applyStateWasCalled.count, 1)
            XCTAssertEqual($0.applyStateWasCalled.first?.state as? ReduxMe.Stub.State, state)
            XCTAssertEqual(($0.applyStateWasCalled.first?.action as? ReduxMe.Stub.Action), action)
        }
    }

    func test_dispatch_onEachStepStateIsAsExpected() {

        let action = ReduxMe.Stub.Action()
        let initialState = store.state
        let firstReducerResult = stubReducers.first?.reduceStubResult as! ReduxMe.Stub.State
        let lastReducerResult = stubReducers.last?.reduceStubResult as! ReduxMe.Stub.State

        store.dispatch(action)

        XCTAssertEqual(stubReducers.first!.reduceWasCalled.first!.state as! ReduxMe.Stub.State, initialState)
        XCTAssertEqual(stubReducers.first!.reduceWasCalled.first!.action as! ReduxMe.Stub.Action, action)

        XCTAssertEqual(stubReducers.last!.reduceWasCalled.first!.state as! ReduxMe.Stub.State, firstReducerResult)
        XCTAssertEqual(stubReducers.last!.reduceWasCalled.first!.action as! ReduxMe.Stub.Action, action)

        XCTAssertEqual(store.state, lastReducerResult)
    }
    
    func test_dispatch_stateUpdatedWasCalledOnAllListeners() {

        store.dispatch(ReduxMe.Stub.Action())

        stubListeners.forEach {

            XCTAssertEqual($0.timesStateUpdatedWasCalled, 1)
        }
    }

    // MARK: - subscribe listeners

    func test_subscribe_addsListener_stateUpdatedWasCalledOnceAfterSubscribeAndOneAfterDispatchingAnAction() {

        let stubListener = ReduxMe.Stub.Listener()
        _ = store.subscribe(stubListener)

        XCTAssertEqual(stubListener.timesStateUpdatedWasCalled, 1)

        store.dispatch(ReduxMe.Stub.Action())

        XCTAssertEqual(stubListener.timesStateUpdatedWasCalled, 2)
    }

    func test_subscribe_addsListenerAndCallsUnsubscribeBlock_stateUpdatedWasCalledOnceOnlyAfterSubscribingAndNotAfterDispatchingAnAction() {

        let listener = ReduxMe.Stub.Listener()
        let unsubscribeBlock = store.subscribe(listener)

        XCTAssertEqual(listener.timesStateUpdatedWasCalled, 1)
        unsubscribeBlock()

        store.dispatch(ReduxMe.Stub.Action())

        XCTAssertEqual(listener.timesStateUpdatedWasCalled, 1)
    }

    // MARK: - subscribe middleware

    func test_subscribe_addsMiddleware_stateUpdatedWasCalledOnceAfterSubscribeAndOneAfterDispatchingAnAction() {

        let action = ReduxMe.Stub.Action()

        stubMiddleware.forEach { XCTAssertEqual($0.applyStateWasCalled.count, 0) }

        store.dispatch(action)

        stubMiddleware.forEach {
            XCTAssertEqual($0.applyStateWasCalled.first?.action as? ReduxMe.Stub.Action, action)
        }
    }
}
