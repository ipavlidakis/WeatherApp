//
//  AddNewDestinationViewController+SectionsFactory.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

extension AddNewDestinationViewController {

    struct SectionsFactory {

        let fontProvider: FontProviding
        let colorProvider: ColorProviding
        let searchLocationAdapter: SearchLocationAdapter
        let destinationsProvider: () -> [Destination]
        let store: ReduxMe.Store<AppState>

        func makeSections() -> [SectionProtocol] {

            var sections = [SectionProtocol?]()

            switch searchLocationAdapter.state {
            case .loading:
                sections.append(AddNewDestinationViewController.LoadingSection(
                    configurator: AddDestinationsLoadingTableViewCellConfigurator(
                        fontProvider: fontProvider,
                        colorProvider: colorProvider)))
            case .loaded where searchLocationAdapter.items.count == 0: break
            case .loaded:

                let dispatcher: (_ destination: Destination) -> Void = {

                    self.store.dispatch(UpdateDestinations(
                        destinations: self.store.state.destinationsState.destinations + [$0]))
                }

                sections.append(AddNewDestinationViewController.SearchResultsSection(
                    configurator: SingleDestinationTableViewCellConfigurator(
                        fontProvider: fontProvider,
                        colorProvider: colorProvider),
                    viewModels: searchLocationAdapter.items,
                    destinationsProvider: destinationsProvider,
                    searchLocationAdapter: searchLocationAdapter,
                    dispatcher: dispatcher))
            }

            return sections.compactMap { $0 }
        }
    }
}
