//
//  LoadingState.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 26/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

enum LoadingState: Equatable {

    case neverLoaded
    case loading
    case loaded
    case failed(error: Error)

    static func ==(lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.neverLoaded, .neverLoaded),
             (.loading, .loading),
             (.loaded, .loaded):
            return true
        case (.failed(let lhsError), .failed(let rhsError)) where lhsError.localizedDescription == rhsError.localizedDescription:
            return true
        default:
            return false
        }
    }
}
