//
//  Flags.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 30/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

enum Units: String, Codable, Equatable {

    case ca
    case uk2
    case us
    case si

    var measurementUnits: MeasurementUnits {

        switch self {
        case .ca:
            return MeasurementUnits.CA
        case .uk2:
            return MeasurementUnits.UK
        case .us:
            return MeasurementUnits.US
        case .si:
            return MeasurementUnits.SI
        }
    }
}


struct Flags: Codable, Equatable {

    let units: Units
}
