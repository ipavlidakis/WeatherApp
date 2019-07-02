//
//  ForecastState.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 26/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct ForecastState: ReduxMeSubstateProtocol, Equatable {

    let name: String
    let coordinates: Coordinates
    let forecast: Forecast?
    let isLoading: LoadingState

    static let initial = ForecastState(
        name: "Unknown",
        coordinates: Coordinates(latitude: 0, longitude: 0),
        forecast: nil,
        isLoading: .neverLoaded)
}
