//
//  ObservableProtocol.swift
//  ReduxMe
//
//  Created by Ilias Pavlidakis on 3/5/19.
//  Copyright © 2019 ReduxMe All rights reserved.
//

import Foundation

protocol ReduxMeObservableProtocol {

    associatedtype StateType: ReduxMeStateProtocol
    associatedtype SubstateType: ReduxMeSubstateProtocol

    typealias UpdateBlock = (_ newSubstate: SubstateType) -> Void
    typealias TransformationBlock = (_ state: StateType) -> SubstateType

    @discardableResult func subscribe(on store: ReduxMe.Store<StateType>) -> Self
    @discardableResult func onChange(_ onNextChangeUpdateBlock: @escaping UpdateBlock) -> Self
    @discardableResult func thenUnsubscribe() -> Self
    @discardableResult func disposed(by bag: ReduxMeDisposableBagProtocol) -> Self
}

