//
//  MiddlewareProtocol.swift
//  ReduxMe
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 ReduxMe All rights reserved.
//

import Foundation

protocol ReduxMeMiddlewareProtocol {

    func apply<State: ReduxMeStateProtocol>(
        _ state: State,
        _ action: ReduxMeActionProtocol)
}
