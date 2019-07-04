//
//  Wireframe.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit
import MapKit

protocol WireframeProtocol {

    func makeForecastViewController(
        destination: Destination) -> UIViewController

    func makeListViewController(
        router: Routing) -> UIViewController

    func makeAddNewDestinationViewController() -> UIViewController
}

struct Wireframe {

    let fontProvider: FontProviding
    let colorProvider: ColorProviding
    let store: ReduxMe.Store<AppState>
    let forecastService: ForecastService
    let locationProvider: LocationProvider
}

extension Wireframe: WireframeProtocol {

    func makeNavigationController(
        with rootViewController: UIViewController) -> UINavigationController {

        let navigationController = UINavigationController(
            rootViewController: rootViewController)

        return navigationController
    }

    func makeForecastViewController(
        destination: Destination) -> UIViewController {

        let viewController = ForecastViewController()
        viewController.store = store
        viewController.forecastService = forecastService
        viewController.tableViewAdapter = TableViewAdapter()
        viewController.colorProvider = colorProvider
        viewController.destination = destination
        viewController.tableViewSectionsFactory = ForecastViewController.SectionsFactory(
            fontProvider: fontProvider,
            colorProvider: colorProvider,
            numberOfDaysToFetchProvider: { return self.store.state.settingsState.numberOfDaysToFetch })

        let navigationController = UINavigationController(
            rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true

        return navigationController
    }

    func makeListViewController(
        router: Routing) -> UIViewController {

        let viewController = DestinationsListViewController()
        viewController.store = store
        viewController.router = router
        viewController.tableViewAdapter = TableViewAdapter()
        viewController.tableViewSectionsFactory = DestinationsListViewController.SectionsFactory(
            fontProvider: fontProvider,
            colorProvider: colorProvider,
            locationProvider: locationProvider,
            router: router,
            itemsProvider: { self.store.state.destinationsState.destinations })

        return viewController
    }

    func makeAddNewDestinationViewController() -> UIViewController {

        let viewController = AddNewDestinationViewController()

        viewController.store = store
        viewController.tableViewAdapter = TableViewAdapter()
        viewController.searchLocationAdapter = SearchLocationAdapter(
            searchCompleter: MKLocalSearchCompleter(),
            completionBlock: { [weak viewController] in viewController?.resultsUpdated() })
        viewController.tableViewSectionsFactory = AddNewDestinationViewController.SectionsFactory(
            fontProvider: fontProvider,
            colorProvider: colorProvider,
            searchLocationAdapter: viewController.searchLocationAdapter,
            destinationsProvider: { return self.store.state.destinationsState.destinations },
            store: store)

        return viewController
    }
}
