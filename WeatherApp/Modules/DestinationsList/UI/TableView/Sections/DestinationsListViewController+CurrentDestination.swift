//
//  DestinationsListViewController+CurrentDestination.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 02/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

extension DestinationsListViewController {

    struct CurrentDestination: SectionProtocol {

        let router: Routing
        let configurator: DestinationTableViewCellConfigurator
        let viewModel = Destination(
            coordinates: Coordinates(latitude: 0, longitude: 0),
            name: "Current Location".localized,
            addedAt: Date(),
            isCurrentLocation: true)

        func registerCells(on tableView: UITableView) {

            tableView.register(
                UINib(nibName: "DestinationTableViewCell", bundle: nil),
                forCellReuseIdentifier: "DestinationTableViewCell")
        }

        func configureCell(
            on tableView: UITableView,
            indexPath: IndexPath) -> UITableViewCell {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DestinationTableViewCell") as? DestinationTableViewCell else {

                fatalError("Invalid cell found where expected to find an instance of DestinationTableViewCell")
            }

            configurator.configure(
                cell: cell,
                title: viewModel.name,
                subtitle: "")

            return cell
        }

        func didSelectItem(
            at indexPath: IndexPath,
            on tableView: UITableView) {

            tableView.deselectRow(at: indexPath, animated: true)
            router.showForecast(with: Destination.current)
        }
    }
}
