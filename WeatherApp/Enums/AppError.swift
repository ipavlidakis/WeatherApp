//
//  AppError.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 25/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

enum AppError: Error {

    case parsing
    case noData
    case custom(_ error: Error)
}
