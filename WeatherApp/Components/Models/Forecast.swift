//
//  Forecast.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 25/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct Forecast: Codable, Equatable {

    let latitude: Float
    let longitude: Float
    let timezone: String
    let currently: CurrentlyForecast?
    let minutely: MinutelyDataBlock?
    let hourly: HourlyDataBlock?
    let daily: DailyDataBlock?
    let alerts: [Alert]?
    let flags: Flags
}
