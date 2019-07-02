//
//  TemperatureTableViewCellConfigurator.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 30/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

struct TemperatureTableViewCellConfigurator {

    let fontProvider: FontProviding
    let colorProvider: ColorProviding
}

extension TemperatureTableViewCellConfigurator {

    func configure(
        cell: TemperatureTableViewCell,
        viewModel: TemperatureCellViewModel) {

        cell.backgroundColor = colorProvider.temperatureCellBackground
        cell.contentView.backgroundColor = colorProvider.temperatureCellBackground

        cell.iconLabel.font = fontProvider.temperatureIcon()
        cell.iconLabel.numberOfLines = 1
        cell.iconLabel.textAlignment = .center
        cell.iconLabel.text = viewModel.icon

        cell.temperatureDescription.font = fontProvider.temperatureDescription()
        cell.temperatureDescription.textColor = colorProvider.temperatureDescription
        cell.temperatureDescription.numberOfLines = 0
        cell.temperatureDescription.textAlignment = .center
        cell.temperatureDescription.text = viewModel.temperatureDescription

        cell.temperatureLabel.font = fontProvider.temperatureLabel()
        cell.temperatureLabel.textColor = colorProvider.temperatureLabel
        cell.temperatureLabel.numberOfLines = 0
        cell.temperatureLabel.textAlignment = .center
        cell.temperatureLabel.text = "\(viewModel.temperature) \(viewModel.unit)"
    }
}
