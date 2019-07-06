//
//  MeasurementUnits.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 30/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct MeasurementUnits {

    let summary: String
    let nearestStormDistance: String
    let precipIntensity: String
    let precipIntensityMax: String
    let precipAccumulation: String
    let temperature: String
    let temperatureMin: String
    let temperatureMax: String
    let apparentTemperature: String
    let dewPoint: String
    let windSpeed: String
    let windGust: String
    let pressure: String
    let visibility: String
}

extension MeasurementUnits {

    static let SI = MeasurementUnits(
        summary: "°C",
        nearestStormDistance: "km",
        precipIntensity: "mm/h",
        precipIntensityMax: "mm/h",
        precipAccumulation: "cm",
        temperature: "°C",
        temperatureMin: "°C",
        temperatureMax: "°C",
        apparentTemperature: "°C",
        dewPoint: "°C",
        windSpeed: "m/s",
        windGust: "m/s",
        pressure: "hPA",
        visibility: "km")

    static let CA = MeasurementUnits(
        summary: "°C",
        nearestStormDistance: "km",
        precipIntensity: "mm/h",
        precipIntensityMax: "mm/h",
        precipAccumulation: "cm",
        temperature: "°C",
        temperatureMin: "°C",
        temperatureMax: "°C",
        apparentTemperature: "°C",
        dewPoint: "°C",
        windSpeed: "km/h",
        windGust: "km/h",
        pressure: "hPA",
        visibility: "km")

    static let UK = MeasurementUnits(
        summary: "°C",
        nearestStormDistance: "miles",
        precipIntensity: "mm/h",
        precipIntensityMax: "mm/h",
        precipAccumulation: "cm",
        temperature: "°C",
        temperatureMin: "°C",
        temperatureMax: "°C",
        apparentTemperature: "°C",
        dewPoint: "°C",
        windSpeed: "mph",
        windGust: "mph",
        pressure: "hPA",
        visibility: "miles")

    static let US = MeasurementUnits(
        summary: "°F",
        nearestStormDistance: "miles",
        precipIntensity: "mm/h",
        precipIntensityMax: "mm/h",
        precipAccumulation: "cm",
        temperature: "°F",
        temperatureMin: "°F",
        temperatureMax: "°F",
        apparentTemperature: "°F",
        dewPoint: "°F",
        windSpeed: "mph",
        windGust: "mph",
        pressure: "hPA",
        visibility: "miles")
}
