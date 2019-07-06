//
//  ForecastPrecipType.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 25/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

enum ForecastPrecipType: String, Codable, Equatable {

    case freezingRain = "rain"
    case icePellets = "snow"
    case winteryMix = "sleet"
}
