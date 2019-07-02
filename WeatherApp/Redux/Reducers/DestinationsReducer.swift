//
//  DestinationsReducer.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct DestinationsReducer: ReduxMeReducerProtocol {

    func reduce<State: ReduxMeStateProtocol>(
        _ state: State,
        _ action: ReduxMeActionProtocol) -> State {

        guard
            let appState = state as? AppState,
            let action = action as? UpdateDestinations
            else { return state }

        return AppState(
            currentLocation: appState.currentLocation,
            forecastState: appState.forecastState,
            unitsState: appState.unitsState,
            destinationsState: DestinationsState(destinations: action.destinations)) as! State
    }
}
