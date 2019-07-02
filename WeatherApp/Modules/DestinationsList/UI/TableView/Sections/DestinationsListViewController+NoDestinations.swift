//
//  DestinationsListViewController+NoDestinations.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

extension DestinationsListViewController {

    struct NoDestinations: SectionProtocol {

        let configurator: NoDestinationsTableViewCellConfigurator

        func registerCells(on tableView: UITableView) {

            tableView.register(
                UINib(nibName: "NoDestinationsTableViewCell", bundle: nil),
                forCellReuseIdentifier: "NoDestinationsTableViewCell")
        }

        func configureCell(
            on tableView: UITableView,
            indexPath: IndexPath) -> UITableViewCell {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoDestinationsTableViewCell") as? NoDestinationsTableViewCell else {

                fatalError("Invalid cell found where expected to find an instance of NoDestinationsTableViewCell")
            }

            configurator.configure(
                cell: cell,
                title: "No destinations found".localized,
                subtitle: "Why not adding a new one?".localized)

            return cell
        }
    }
}
