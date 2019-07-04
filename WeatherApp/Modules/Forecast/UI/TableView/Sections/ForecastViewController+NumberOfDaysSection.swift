//
//  ForecastViewController+NumberOfDaysSection.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 04/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

extension ForecastViewController {

    struct NumberOfDaysSection: SectionProtocol {

        let configurator: NumberOfDaysTemperatureTableViewCellConfigurator

        var viewModel: NumberOfDaysCellViewModel

        var numberOfItems: Int { return 1 }

        func registerCells(on tableView: UITableView) {

            tableView.register(
                UINib(nibName: "NumberOfDaysTableViewCell", bundle: .main),
                forCellReuseIdentifier: "NumberOfDaysTableViewCell")
        }

        func configureCell(
            on tableView: UITableView,
            indexPath: IndexPath) -> UITableViewCell {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NumberOfDaysTableViewCell") as? NumberOfDaysTableViewCell else {

                fatalError("Invalid cell found where expected to find an instance of NumberOfDaysTableViewCell")
            }

            configurator.configure(cell: cell, viewModel: viewModel)

            return cell
        }

        func shouldHighlightRow(at row: Int) -> Bool {
            return false
        }
    }
}
