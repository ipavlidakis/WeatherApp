//
//  DailyDataBlock.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 25/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct DailyDataBlock: Codable, Equatable {

    let data: [DailyForecast]
    let summary: String?
    let icon: String?
}
