//
//  SettingsProvider.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

final class SettingsProvider: NSObject {

    enum Keys: String {

        case version = "version_preference"
        case build = "build_preference"
        case useImperialUnits = "use_imperial_units"
    }

    private let store: ReduxMe.Store<AppState>
    private let notificationCenter: NotificationCenter
    private let keysValueStore: KeyValueStoreProtocol

    init(store: ReduxMe.Store<AppState>,
         notificationCenter: NotificationCenter,
         keysValueStore: KeyValueStoreProtocol) {

        self.store = store
        self.notificationCenter = notificationCenter
        self.keysValueStore = keysValueStore

        super.init()

        notificationCenter.addObserver(
            self,
            selector: #selector(settingsUpdated),
            name: UserDefaults.didChangeNotification,
            object: nil)

        guard
            let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
            let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        else { return }

        UserDefaults.standard.set(appVersion, forKey: Keys.version.rawValue)
        UserDefaults.standard.set(buildNumber, forKey: Keys.build.rawValue)
    }
}

extension SettingsProvider {

    @objc
    func settingsUpdated() {

        store.dispatch(
            UpdateUnitsAction(
                unit: keysValueStore.bool(forKey: Keys.useImperialUnits.rawValue)
                    ? .us
                    : .si))
    }
}
