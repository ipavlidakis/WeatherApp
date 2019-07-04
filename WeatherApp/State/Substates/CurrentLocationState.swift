//
//  CurrentLocationState.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 26/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct CurrentLocationState: ReduxMeSubstateProtocol, Equatable {

    let name: String
    let coordinates: Coordinates
    let hasAccess: Bool

    static let initial = CurrentLocationState(
        name: "Current Location",
        coordinates: Coordinates(latitude: 0, longitude: 0),
        hasAccess: false)
}
