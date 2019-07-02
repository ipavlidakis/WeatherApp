//
//  CompoundReducer.swift
//  ReduxMe
//
//  Created by Ilias Pavlidakis on 01/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

extension ReduxMe {

    struct CompoundReducer {

        let reducers: [ReduxMeReducerProtocol]
    }
}

extension ReduxMe.CompoundReducer: ReduxMeReducerProtocol {

    func reduce<T>(
        _ state: T, _ action: ReduxMeActionProtocol) -> T where T : ReduxMeStateProtocol {

        return reducers.reduce(state) { $1.reduce($0, action) }
    }
}
