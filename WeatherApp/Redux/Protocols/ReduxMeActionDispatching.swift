//
//  ActionDispatching.swift
//  ReduxMe
//
//  Created by Ilias Pavlidakis on 14/02/2019.
//  Copyright © 2019 ReduxMe All rights reserved.
//

import Foundation

protocol ReduxMeActionDispatching {

    func dispatch(
        _ action: ReduxMeActionProtocol)
}
