//
//  ForecastViewController+DailyForecastSection.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 30/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

extension ForecastViewController {

    struct DailyForecastSection: SectionProtocol {

        let configurator: DailyForecastTableViewCellConfigurator

        var viewModels: [DailyForecastViewModel]

        var numberOfItems: Int { return viewModels.count }

        func registerCells(on tableView: UITableView) {

            tableView.register(
                UINib(nibName: "DailyForecastTableViewCell", bundle: .main),
                forCellReuseIdentifier: "DailyForecastTableViewCell")
        }

        func configureCell(
            on tableView: UITableView,
            indexPath: IndexPath) -> UITableViewCell {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DailyForecastTableViewCell") as? DailyForecastTableViewCell else {

                fatalError("Invalid cell found where expected to find an instance of DailyForecastTableViewCell")
            }

            configurator.configure(cell: cell, viewModel: viewModels[indexPath.row])

            return cell
        }

        func shouldHighlightRow(at row: Int) -> Bool {
            return false
        }
    }
}
