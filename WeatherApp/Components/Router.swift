//
//  Router.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

protocol Routing {

    func showForecast(with destination: Destination)

    func presentDestinationsList()

    func pushAddNewDestination()
}

struct Router {

    private let navigator: NavigatorProtocol
    private let splitNavigator: SplitNavigatorProtocol
    private let wireframe: WireframeProtocol

    init(navigator: NavigatorProtocol,
         splitNavigator: SplitNavigatorProtocol,
         wireframe: WireframeProtocol) {

        self.navigator = navigator
        self.splitNavigator = splitNavigator
        self.wireframe = wireframe
    }
}

extension Router: Routing {

    func showForecast(with destination: Destination) {

        let viewController = wireframe.makeForecastViewController(
            destination: destination)

        splitNavigator.showDetailViewController(
            viewController,
            sender: nil)
    }

    func presentDestinationsList() {

        navigator.present(
            wireframe.makeListViewController(router: self),
            animated: true,
            completion: nil)
    }

    func pushAddNewDestination() {

        navigator.pushViewController(
            wireframe.makeAddNewDestinationViewController(),
            animated: true)
    }
}

