//
//  ListenerProtocol.swift
//  ReduxMe
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 ReduxMe All rights reserved.
//

import Foundation

public extension ReduxMe {

    typealias UnsubscribeListener = () -> Void
}

public protocol ReduxMeListenerProtocol {

    var identifier: UUID { get }

    func stateUpdated()
}

extension ReduxMeListenerProtocol where Self: Equatable {

    static func ==(
        lhs: ReduxMeListenerProtocol,
        rhs: ReduxMeListenerProtocol) -> Bool {

        return lhs.identifier == rhs.identifier
    }
}

extension ReduxMeListenerProtocol where Self: Hashable {

    var hashValue: Int { return identifier.hashValue }
}

