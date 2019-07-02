//
//  CurrentLocationReducer.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 26/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct CurrentLocationReducer: ReduxMeReducerProtocol {

    func reduce<State: ReduxMeStateProtocol>(
        _ state: State,
        _ action: ReduxMeActionProtocol) -> State {

        guard let appState = state as? AppState else { return state }

        switch action {
        case let action as LocationAction.UpdateAuthorization:

            let currentLocation = CurrentLocationState(
                name: appState.currentLocation.name,
                coordinates: appState.currentLocation.coordinates,
                hasAccess: action.hasAccess)

            return AppState(
                currentLocation: currentLocation,
                forecastState: appState.forecastState,
                unitsState: appState.unitsState,
                destinationsState: appState.destinationsState) as! State

        case let action as LocationAction.UpdateLocation:

            let currentLocation = CurrentLocationState(
                name: action.name,
                coordinates: action.coordinates,
                hasAccess: appState.currentLocation.hasAccess)

            return AppState(
                currentLocation: currentLocation,
                forecastState: appState.forecastState,
                unitsState: appState.unitsState,
                destinationsState: appState.destinationsState) as! State
        default:
            return state
        }
    }
}
