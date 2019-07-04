//
//  SettingsState.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct SettingsState: ReduxMeSubstateProtocol, Equatable {

    let unit: Units
    let numberOfDaysToFetch: Int

    static let initial = SettingsState(unit: .si, numberOfDaysToFetch: 5)
}
