//
//  AddNewDestinationViewController+SearchResultsSection.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

extension AddNewDestinationViewController {

    struct SearchResultsSection: SectionProtocol {

        let configurator: SingleDestinationTableViewCellConfigurator
        let viewModels: [(title: String, subtitle: String)]
        let destinationsProvider: () -> [Destination]
        let searchLocationAdapter: SearchLocationAdapter
        let dispatcher: (_ destination: Destination) -> Void

        var numberOfItems: Int { return viewModels.count }

        func registerCells(on tableView: UITableView) {

            tableView.register(
                UINib(nibName: "SingleDestinationTableViewCell", bundle: nil),
                forCellReuseIdentifier: "SingleDestinationTableViewCell")
        }

        func configureCell(
            on tableView: UITableView,
            indexPath: IndexPath) -> UITableViewCell {

            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "SingleDestinationTableViewCell") as? SingleDestinationTableViewCell
                else {
                    fatalError("Invalid cell found where expected to find an instance of SingleDestinationTableViewCell")
            }

            let viewModel = viewModels[indexPath.row]

            configurator.configure(
                cell: cell,
                title: viewModel.title,
                subtitle: viewModel.subtitle)

            return cell
        }

        func didSelectItem(at indexPath: IndexPath, on tableView: UITableView) {

            tableView.deselectRow(at: indexPath, animated: true)

            guard
                let cell = tableView.cellForRow(at: indexPath) as? SingleDestinationTableViewCell
                else {
                    fatalError("Invalid cell found where expected to find an instance of SingleDestinationTableViewCell")
            }

            tableView.isUserInteractionEnabled = false

            let viewModel = viewModels[indexPath.row]

            configurator.configureForLoading(
                cell: cell,
                title: viewModel.title,
                subtitle: viewModel.subtitle)

            searchLocationAdapter.fetchItem(at: indexPath.row) { (destination) in

                guard let destination = destination else {

                    tableView.isUserInteractionEnabled = true
                    self.configurator.configure(
                        cell: cell,
                        title: viewModel.title,
                        subtitle: viewModel.subtitle)

                    return
                }

                self.dispatcher(destination)
            }
        }
    }
}
