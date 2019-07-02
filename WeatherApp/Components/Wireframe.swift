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

    func makeForecastViewController(router: Routing) -> UIViewController

    func makeListViewController() -> UIViewController

    func makeAddNewDestinationViewController(router: Routing) -> UIViewController
}

struct Wireframe {

    let fontProvider: FontProviding
    let colorProvider: ColorProviding
    let store: ReduxMe.Store<AppState>
    let forecastService: ForecastService
    let locationProvider: LocationProvider
}

extension Wireframe: WireframeProtocol {

    func makeForecastViewController(router: Routing) -> UIViewController {

        let viewController = ForecastViewController()
        viewController.store = store
        viewController.forecastService = forecastService
        viewController.tableViewAdapter = TableViewAdapter()
        viewController.colorProvider = colorProvider
        viewController.router = router
        viewController.tableViewSectionsFactory = ForecastViewController.SectionsFactory(
            fontProvider: fontProvider,
            colorProvider: colorProvider)

        return viewController
    }

    func makeListViewController() -> UIViewController {

        let navigationController = UINavigationController()
        let viewController = DestinationsListViewController()
        viewController.store = store
        viewController.router = Router(
            navigator: navigationController,
            wireframe: self)
        viewController.tableViewAdapter = TableViewAdapter()
        viewController.tableViewSectionsFactory = DestinationsListViewController.SectionsFactory(
            fontProvider: fontProvider,
            colorProvider: colorProvider,
            locationProvider: locationProvider,
            itemsProvider: { self.store.state.destinationsState.destinations })

        navigationController.viewControllers = [viewController]
        navigationController.navigationBar.prefersLargeTitles = true

        return navigationController
    }

    func makeAddNewDestinationViewController(router: Routing) -> UIViewController {

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
