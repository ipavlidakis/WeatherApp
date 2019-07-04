//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 25/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = UIWindow()
    private var store: ReduxMe.Store<AppState>!
    private lazy var locationProvider = LocationProvider(store: store)
    private lazy var settingsProvider = SettingsProvider(store: store, notificationCenter: NotificationCenter.default, keysValueStore: UserDefaults.standard)
    private lazy var wireframe = Wireframe(
        fontProvider: FontProvider(),
        colorProvider: ColorProvider(), store: store,
        forecastService: ForecastService(),
        locationProvider: locationProvider)
    private lazy var destinationsProvider = DestinationsProvider(
        keyValueStore: UserDefaults.standard,
        encoder: JSONEncoder(),
        decoder: JSONDecoder(),
        store: store,
        queue: DispatchQueue.global(qos: .background))

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        store = ReduxMe.Store<AppState>(
            state: .initial,
            reducers: [CurrentLocationReducer(), SettingsReducer(), DestinationsReducer()])

        _ = settingsProvider
        _ = destinationsProvider

        let splitViewController =  UISplitViewController()

        let detailsViewController = wireframe.makeForecastViewController(
            destination: Destination.current)

        let masterViewController = UINavigationController()
        masterViewController.navigationBar.prefersLargeTitles = true
        let listViewController = wireframe.makeListViewController(
            router: Router(
                navigator: masterViewController,
                splitNavigator: splitViewController,
                wireframe: wireframe))
        masterViewController.viewControllers = [listViewController]

        splitViewController.viewControllers = [masterViewController, detailsViewController]

        window?.rootViewController = splitViewController

        window?.makeKeyAndVisible()

        return true
    }
}

extension AppDelegate {

    func applicationWillResignActive(_ application: UIApplication) {

        locationProvider.stopMonitoring()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

        locationProvider.startMonitoring()
    }
}

