//
//  Observable.swift
//  ReduxMe
//
//  Created by Ilias Pavlidakis on 3/5/19.
//  Copyright © 2019 ReduxMe All rights reserved.
//

import Foundation

extension ReduxMe {

    final class Observable<State: ReduxMeStateProtocol, Substate: ReduxMeSubstateProtocol & Equatable> {

        typealias StateType = State
        typealias SubstateType = Substate
        private let _identifier: UUID = UUID()

        private var unsubscribeBlock: UnsubscribeListener?

        private var onChangeUpdateBlock: UpdateBlock?
        private var onChangeDisposeBlock: (() -> Void)?
        private var lastUsedSubstate: Substate?
        private var store: ReduxMe.Store<State>!

        private let transformationBlock: TransformationBlock

        init(transformationBlock: @escaping TransformationBlock) {

            self.transformationBlock = transformationBlock
        }

        deinit {

            unsubscribeBlock?()
        }
    }
}

extension ReduxMe.Observable: ReduxMeObservableProtocol {

    @discardableResult
    func subscribe(on store: ReduxMe.Store<State>) -> Self {

        self.store = store
        
        self.unsubscribeBlock = store.subscribe(self)

        return self
    }

    @discardableResult
    func onChange(_ onChangeUpdateBlock: @escaping UpdateBlock) -> Self {

        guard let _ = store else {

            assertionFailure("You subscribe to store before call onChange on Observables")

            return self
        }

        lastUsedSubstate = transformationBlock(store.state)

        self.onChangeUpdateBlock = onChangeUpdateBlock

        return self
    }

    @discardableResult
    func thenUnsubscribe() -> Self {

        onChangeDisposeBlock = { [weak self] in

            self?.unsubscribeBlock?()
        }

        return self
    }

    @discardableResult
    func disposed(
        by bag: ReduxMeDisposableBagProtocol) -> Self {

        bag.add(self)

        return self
    }
}

extension ReduxMe.Observable: ReduxMeDisposable {

    func onDispose() {

        unsubscribeBlock?()
    }
}

extension ReduxMe.Observable: ReduxMeListenerProtocol {

    var identifier: UUID { return _identifier }

    func stateUpdated() {

        let substate = transformationBlock(store.state)
        let localLastUsedSubstate = self.lastUsedSubstate
        self.lastUsedSubstate = substate

        if localLastUsedSubstate == nil {

            onChangeUpdateBlock?(substate)
            onChangeDisposeBlock?()
        } else if
            let localLastUsedSubstate = localLastUsedSubstate,
            localLastUsedSubstate != substate {

            onChangeUpdateBlock?(substate)
            onChangeDisposeBlock?()
        }
    }
}
