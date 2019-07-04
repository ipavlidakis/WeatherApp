//
//  DestinationsListViewController+Destinations.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

extension DestinationsListViewController {

    struct Destinations: SectionProtocol {

        let router: Routing
        let configurator: DestinationTableViewCellConfigurator
        let dateFormatter: DateFormatter
        let viewModels: [Destination]

        var numberOfItems: Int { return viewModels.count }

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

            let viewModel = viewModels[indexPath.row]

            configurator.configure(
                cell: cell,
                title: viewModel.name,
                subtitle: dateFormatter.string(from: viewModel.addedAt))

            return cell
        }

        func didSelectItem(
            at indexPath: IndexPath,
            on tableView: UITableView) {

            tableView.deselectRow(at: indexPath, animated: true)

            let destination = viewModels[indexPath.row]

            router.showForecast(with: destination)
        }
    }
}
