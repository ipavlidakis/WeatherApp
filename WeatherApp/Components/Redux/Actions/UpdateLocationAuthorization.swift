//
//  UpdateLocationAuthorization.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 26/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

enum LocationAction {

    struct UpdateAuthorization: ReduxMeActionProtocol {

        let hasAccess: Bool
    }

    struct RequestUpdatedLocation: ReduxMeActionProtocol {}

    struct UpdateLocation: ReduxMeActionProtocol {

        let name: String
        let coordinates: Coordinates
    }
}
