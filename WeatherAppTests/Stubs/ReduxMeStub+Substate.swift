//
//  ReduxMeStub+Substate.swift
//  ReduxMe Tests
//
//  Created by Ilias Pavlidakis on 01/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
@testable import WeatherApp

extension ReduxMe.Stub {

    struct Substate: ReduxMeSubstateProtocol, Equatable {

        let identifier = UUID()

        static let initial = Substate()
    }
}
