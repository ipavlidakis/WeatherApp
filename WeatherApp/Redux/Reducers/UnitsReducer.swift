//
//  UnitsReducer.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct UnitsReducer: ReduxMeReducerProtocol {

    func reduce<State: ReduxMeStateProtocol>(
        _ state: State,
        _ action: ReduxMeActionProtocol) -> State {

        guard
            let appState = state as? AppState,
            let action = action as? UpdateUnitsAction
        else { return state }

        return AppState(
            currentLocation: appState.currentLocation,
            forecastState: appState.forecastState,
            unitsState: UnitsState(unit: action.unit),
            destinationsState: appState.destinationsState) as! State
    }
}
