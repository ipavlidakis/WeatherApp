//
//  AppState.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 26/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct AppState: ReduxMeStateProtocol {

    let currentLocation: CurrentLocationState
    let settingsState: SettingsState
    let destinationsState: DestinationsState

    static let initial = AppState(
        currentLocation: .initial,
        settingsState: .initial,
        destinationsState: .initial)
}
