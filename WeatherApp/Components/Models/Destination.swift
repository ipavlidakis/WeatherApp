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
    let isCurrentLocation: Bool
}

extension Destination {

    static let current = Destination(
        coordinates: Coordinates(latitude: 0, longitude: 0),
        name: "Current Location".localized,
        addedAt: Date(),
        isCurrentLocation: true)
}
