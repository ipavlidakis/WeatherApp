//
//  AddNewDestinationViewController+LoadingSection.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

extension AddNewDestinationViewController {

    struct LoadingSection: SectionProtocol {

        let configurator: AddDestinationsLoadingTableViewCellConfigurator

        func registerCells(on tableView: UITableView) {

            tableView.register(
                UINib(nibName: "AddDestinationsLoadingTableViewCell", bundle: nil),
                forCellReuseIdentifier: "AddDestinationsLoadingTableViewCell")
        }

        func configureCell(
            on tableView: UITableView,
            indexPath: IndexPath) -> UITableViewCell {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddDestinationsLoadingTableViewCell") as? AddDestinationsLoadingTableViewCell else {

                fatalError("Invalid cell found where expected to find an instance of AddDestinationsLoadingTableViewCell")
            }

            configurator.configure(
                cell: cell,
                title: "Loading".localized)

            return cell
        }
    }
}
