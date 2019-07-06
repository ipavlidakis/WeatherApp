//
//  DailyForecast.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 25/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct DailyForecast: Codable, Equatable {

    let apparentTemperatureHigh: Float?
    let apparentTemperatureHighTime: Int?
    let apparentTemperatureLow: Float?
    let apparentTemperatureLowTime: Int?
    let apparentTemperatureMax: Float?
    let apparentTemperatureMaxTime: Int?
    let apparentTemperatureMin: Float?
    let apparentTemperatureMinTime: Int?
    let cloudCover: Float?
    let dewPoint: Float?
    let humidity: Float?
    let icon: ForecastIcon?
    let ozone: Float?
    let precipAccumulation: Float?
    let precipIntensity: Float?
    let precipIntensityError: Float?
    let precipIntensityMax: Float?
    let precipIntensityMaxTime: Float?
    let precipProbability: Float?
    let precipType: ForecastPrecipType?
    let pressure: Float?
    let summary: String?
    let sunriseTime: Int?
    let sunsetTime: Int?
    let temperatureHigh: Float?
    let temperatureHighTime: Int?
    let temperatureLow: Float?
    let temperatureLowTime: Int?
    let temperatureMax: Float?
    let temperatureMaxTime: Int?
    let temperatureMin: Float?
    let temperatureMinTime: Int?
    let time: TimeInterval
    let uvIndex: Float?
    let uvIndexTime: Int?
    let visibility: Float?
    let windBearing: Float?
    let windGust: Float?
    let windGustTime: Int?
    let windSpeed: Float?
}
