//
//  Alert.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 25/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct Alert: Codable, Equatable {

    let description: String
    let expires: Int
    let regions: [String]
    let severity: AlertSeverity
    let time: Int
    let title: String
    let uri: URL
}
