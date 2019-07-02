//
//  SubstateListenerProtocol.swift
//  ReduxMe
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 ReduxMe All rights reserved.
//

import Foundation

public protocol ReduxMeSubstateListenerProtocol {

    associatedtype Substate: ReduxMeSubstateProtocol

    func substateUpdated(
        _ newState: Substate)
}
