//
//  Destination.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct Destination: Codable, Equatable {

    let coordinates: Coordinates
    let name: String
    let addedAt: Date
}
