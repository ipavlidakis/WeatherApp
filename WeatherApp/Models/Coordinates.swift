//
//  Coordinates.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 25/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct Coordinates: Equatable, Codable {

    let latitude: Double
    let longitude: Double
}

extension Coordinates: CustomStringConvertible {

    var description: String {

        return "\(latitude),\(longitude)"
    }
}
