//
//  DestinationsListViewController+SectionsFactory.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

extension DestinationsListViewController {

    struct SectionsFactory {

        let fontProvider: FontProviding
        let colorProvider: ColorProviding
        let locationProvider: LocationProvider
        let itemsProvider: () -> [Destination]

        func makeSections() -> [SectionProtocol] {

            var sections = [SectionProtocol?]()

            if locationProvider.isAuthorized() {
                
                sections.append(DestinationsListViewController.CurrentDestination(
                    configurator: DestinationTableViewCellConfigurator(
                        fontProvider: fontProvider,
                        colorProvider: colorProvider)))
            }

            if itemsProvider().count == 0 {
                sections.append(DestinationsListViewController.NoDestinations(
                    configurator: NoDestinationsTableViewCellConfigurator(
                        fontProvider: fontProvider,
                        colorProvider: colorProvider)))
            } else {

                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none

                sections.append(DestinationsListViewController.Destinations(
                    configurator: DestinationTableViewCellConfigurator(
                        fontProvider: fontProvider,
                        colorProvider: colorProvider),
                    dateFormatter: dateFormatter,
                    viewModels: itemsProvider()))
            }

            return sections.compactMap { $0 }
        }
    }
}
