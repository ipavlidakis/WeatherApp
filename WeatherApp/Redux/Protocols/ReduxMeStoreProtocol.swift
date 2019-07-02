//
//  StoreProtocol.swift
//  ReduxMe
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 ReduxMe All rights reserved.
//

import Foundation

protocol ReduxMeStoreProtocol: ReduxMeActionDispatching {

    associatedtype State

    var state: State { get }

    func subscribe(
        _ listener: ReduxMeListenerProtocol) -> ReduxMe.UnsubscribeListener

    func subscribe(
        _ middleware: ReduxMeMiddlewareProtocol)
}
