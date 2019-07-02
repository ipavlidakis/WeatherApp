//
//  LocationProvider.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 26/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import CoreLocation

final class LocationProvider: NSObject {

    private let locationManager: CLLocationManager
    private let geoCoder: CLGeocoder
    private let store: ReduxMe.Store<AppState>

    init(locationManager: CLLocationManager = CLLocationManager(),
         geoCoder: CLGeocoder = CLGeocoder(),
         store: ReduxMe.Store<AppState>) {

        self.locationManager = locationManager
        self.geoCoder = geoCoder
        self.store = store

        super.init()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
}

private extension LocationProvider {

    func reverseGeoCode(location: CLLocation) {

        geoCoder.reverseGeocodeLocation(location) { [weak self] (placemarks, _) in

            guard let name = placemarks?.first?.name else { return }

            self?.store.dispatch(LocationAction.UpdateLocation(
                name: name,
                coordinates: Coordinates(
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude)))
        }
    }
}

extension LocationProvider {

    func startMonitoring() {
        locationManager.startUpdatingLocation()
    }

    func stopMonitoring() {
        locationManager.stopUpdatingLocation()
    }

    func isAuthorized() -> Bool {

        return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }
}

extension LocationProvider: CLLocationManagerDelegate {

    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus) {

        store.dispatch(LocationAction.UpdateAuthorization(
            hasAccess: status == .authorizedWhenInUse))
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {

        guard let currentLocation = locations.first else { return }

        reverseGeoCode(location: currentLocation)
    }
}

extension LocationProvider: ReduxMeMiddlewareProtocol {

    func apply<State>(
        _ state: State,
        _ action: ReduxMeActionProtocol) where State : ReduxMeStateProtocol {

        guard
            let _ = state as? AppState,
            let _ = action as? LocationAction.RequestUpdatedLocation,
            let currentLocation = locationManager.location
        else { return }

        reverseGeoCode(location: currentLocation)
    }
}
