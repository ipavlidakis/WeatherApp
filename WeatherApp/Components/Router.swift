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

    func showForecast()

    func presentDestinationsList()

    func pushAddNewDestination()
}

struct Router {

    private let navigator: NavigatorProtocol
    private let wireframe: WireframeProtocol

    init(navigator: NavigatorProtocol,
         wireframe: WireframeProtocol) {

        self.navigator = navigator
        self.wireframe = wireframe
    }
}

extension Router: Routing {

    func showForecast() {

        navigator.viewControllers = [
            wireframe.makeForecastViewController(router: self)
        ]
    }

    func presentDestinationsList() {

        navigator.present(
            wireframe.makeListViewController(),
            animated: true,
            completion: nil)
    }

    func pushAddNewDestination() {

        navigator.pushViewController(
            wireframe.makeAddNewDestinationViewController(router: self),
            animated: true)
    }
}

