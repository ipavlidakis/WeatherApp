//
//  NavigatorProtocol.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

protocol NavigatorProtocol: class {

    var viewControllers: [UIViewController] { get set }

    func pushViewController(
        _ viewController: UIViewController,
        animated: Bool)

    func present(
        _ viewControllerToPresent: UIViewController,
        animated flag: Bool,
        completion: (() -> Void)?)
}
