//
//  UnitsState.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct UnitsState: ReduxMeSubstateProtocol, Equatable {

    let unit: Units

    static let initial = UnitsState(unit: .si)
}
