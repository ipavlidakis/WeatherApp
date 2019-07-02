//
//  DestinationsState.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct DestinationsState: ReduxMeSubstateProtocol, Equatable {

    let destinations: [Destination]

    static let initial = DestinationsState(destinations: [])
}
