//
//  ForecastViewController+TemperatureSection.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 30/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

extension ForecastViewController {

    struct TemperatureSection: SectionProtocol {

        let configurator: TemperatureTableViewCellConfigurator

        var viewModel: TemperatureCellViewModel

        func registerCells(on tableView: UITableView) {

            tableView.register(
                UINib(nibName: "TemperatureTableViewCell", bundle: .main),
                forCellReuseIdentifier: "TemperatureTableViewCell")
        }

        func configureCell(
            on tableView: UITableView,
            indexPath: IndexPath) -> UITableViewCell {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TemperatureTableViewCell") as? TemperatureTableViewCell else {

                fatalError("Invalid cell found where expected to find an instance of TemperatureTableViewCell")
            }

            configurator.configure(cell: cell, viewModel: viewModel)

            return cell
        }
    }
}
