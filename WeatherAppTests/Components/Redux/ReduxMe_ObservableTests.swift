//
//  ReduxMe_ObservableTests.swift
//
//  Created by Ilias Pavlidakis on 3/5/19.
//  Copyright © 2019 ReduxMe All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherApp

final class ReduxMe_ObservableTests: XCTestCase {

    private var stubStore: ReduxMe.Stub.Store! = ReduxMe.Stub.Store()
    private var transformationBlockWasCalledWithState: ReduxMe.Stub.State?
    private lazy var observable: ReduxMe.Observable! = ReduxMe.Observable<ReduxMe.Stub.State, ReduxMe.Stub.Substate> {
        self.transformationBlockWasCalledWithState = $0
        return $0.substate
    }

    override func tearDown() {

        stubStore = nil
        transformationBlockWasCalledWithState = nil
        observable = nil

        super.tearDown()
    }
}

extension ReduxMe_ObservableTests {

    // MARK: subscribe

    func test_subscribe_subscribesOnStoreAsListener() {

        observable.subscribe(on: stubStore)

        XCTAssert((stubStore.subscribeWasCalledWithListeners.first as? ReduxMe.Observable<ReduxMe.Stub.State, ReduxMe.Stub.Substate>) === observable)
    }

    func test_subscribe_returnsSelf() {

        XCTAssert(observable.subscribe(on: stubStore) === observable)
    }

    // MARK: onChange

    func test_onChange_returnsSelf() {

        observable.subscribe(on: stubStore)

        XCTAssert(observable.onChange({ _ in }) === observable)
    }

    // MARK: thenUnsubscribe

    func test_thenUnsubscribe_returnsSelf() {

        XCTAssert(observable.thenUnsubscribe() === observable)
    }

    // MARK: dispose

    func test_dispose_returnsSelf() {

        XCTAssert(observable.disposed(by: ReduxMe.Stub.DisposeBag()) === observable)
    }

    func test_dispose_addSelfOnDisposableBag() {

        let disposableBag = ReduxMe.Stub.DisposeBag()

        observable.disposed(by: disposableBag)

        XCTAssert(disposableBag.elements.first is ReduxMe.Observable<ReduxMe.Stub.State, ReduxMe.Stub.Substate>)
    }
}

extension ReduxMe_ObservableTests {

    // MARK: onDispose

    func test_onDispose_unsubscribeWasCalled() {

        var blockWasExecuted = true
        stubStore.unsubscribeStubResult = { blockWasExecuted = true }
        observable.subscribe(on: stubStore)

        observable.onDispose()

        XCTAssert(blockWasExecuted)
    }
}

extension ReduxMe_ObservableTests {

    // MARK: stateUpdated

    func test_stateUpdated_onChange_transformationBlockWasCalledWithExpectedState() {

        observable.subscribe(on: stubStore)
            .onChange({ _ in })
            .thenUnsubscribe()
        stubStore.stubState = ReduxMe.Stub.State(substate: ReduxMe.Stub.Substate())

        observable.stateUpdated()

        XCTAssertEqual(transformationBlockWasCalledWithState, stubStore.stubState)
    }

    func test_stateUpdated_onChange_hasLastUsedSubstate_newStateIsEqual_doesNotCallChangeBlock() {

        var blockWasCalled = false
        observable.subscribe(on: stubStore)
            .onChange({ _ in blockWasCalled = true })
            .thenUnsubscribe()

        observable.stateUpdated()

        XCTAssertFalse(blockWasCalled)
    }

    func test_stateUpdated_onChange_hasLastUsedSubstate_newStateIsEqual_doesNotCallUnsubscribe() {

        var blockWasCalled = false
        stubStore.unsubscribeStubResult = { blockWasCalled = true }
        observable.subscribe(on: stubStore)
            .onChange({ _ in })
            .thenUnsubscribe()

        observable.stateUpdated()

        XCTAssertFalse(blockWasCalled)
    }

    func test_stateUpdated_onChange_hasLastUsedSubstate_newStateIsNotEqual_callsUpdateWithNewSubstate() {

        var blockWasCalledWithState: ReduxMe.Stub.Substate?
        observable.subscribe(on: stubStore)
            .onChange({ blockWasCalledWithState = $0 })
            .thenUnsubscribe()
        stubStore.stubState = ReduxMe.Stub.State(substate: ReduxMe.Stub.Substate())
        let expectedSubstate = stubStore.stubState.substate

        observable.stateUpdated()

        XCTAssertEqual(blockWasCalledWithState, expectedSubstate)
    }

    func test_stateUpdated_onChange_hasLastUsedSubstate_newStateIsNotEqual_callsUnsubscribe() {

        var blockWasCalled = false
        stubStore.unsubscribeStubResult = { blockWasCalled = true }
        observable.subscribe(on: stubStore)
            .onChange({ _ in })
            .thenUnsubscribe()
        stubStore.stubState = ReduxMe.Stub.State(substate: ReduxMe.Stub.Substate())

        observable.stateUpdated()

        XCTAssert(blockWasCalled)
    }
}
