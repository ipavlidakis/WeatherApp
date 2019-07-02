//
//  HourlyForecast.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 25/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct HourlyForecast: Codable, Equatable {

    let apparentTemperature: Float?
    let cloudCover: Float?
    let dewPoint: Float?
    let humidity: Float?
    let icon: ForecastIcon?
    let moonPhase: Float?
    let ozone: Float?
    let precipAccumulation: Float?
    let precipIntensity: Float?
    let precipIntensityError: Float?
    let precipProbability: Float?
    let precipType: ForecastPrecipType?
    let pressure: Float?
    let summary: String?
    let temperature: Float?
    let time: TimeInterval
    let uvIndex: Float?
    let visibility: Float?
    let windBearing: Float?
    let windGust: Float?
    let windSpeed: Float?
}
