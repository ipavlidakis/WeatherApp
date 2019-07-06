//
//  ForecastIcon.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 25/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

enum ForecastIcon: String, Codable, Equatable {

    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case rain
    case snow
    case sleet
    case wind
    case fog
    case cloudy
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"

    var icon: String {

        switch self {
        case .clearDay:
            return "☀️"
        case .clearNight:
            return "🌕"
        case .rain:
            return "🌧"
        case .snow:
            return "❄️"
        case .sleet:
            return "🌨"
        case .wind:
            return "💨"
        case .fog:
            return "🌫"
        case .cloudy:
            return "☁️"
        case .partlyCloudyDay:
            return "🌤"
        case .partlyCloudyNight:
            return "🌤"
        }
    }
}
