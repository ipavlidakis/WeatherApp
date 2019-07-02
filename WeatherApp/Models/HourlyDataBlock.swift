//
//  HourlyDataBlock.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 25/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct HourlyDataBlock: Codable, Equatable {

    let data: [HourlyForecast]
    let summary: String?
    let icon: String?
}
