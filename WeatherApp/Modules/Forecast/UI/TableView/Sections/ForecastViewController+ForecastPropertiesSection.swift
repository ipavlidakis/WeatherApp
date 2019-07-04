//
//  ForecastViewController+ForecastPropertiesSection.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 30/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

extension ForecastViewController {

    struct ForecastPropertiesSection: SectionProtocol {

        let configurator: ForecastPropertiesTableViewCellConfigurator

        var viewModel: ForecastPropertiesViewModel

        func registerCells(on tableView: UITableView) {

            tableView.register(
                UINib(nibName: "ForecastPropertiesTableViewCell", bundle: .main),
                forCellReuseIdentifier: "ForecastPropertiesTableViewCell")
        }

        func configureCell(
            on tableView: UITableView,
            indexPath: IndexPath) -> UITableViewCell {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastPropertiesTableViewCell") as? ForecastPropertiesTableViewCell else {

                fatalError("Invalid cell found where expected to find an instance of ForecastPropertiesTableViewCell")
            }

            configurator.configure(cell: cell, viewModel: viewModel)

            return cell
        }

        func shouldHighlightRow(at row: Int) -> Bool {
            return false
        }
    }
}
