//
//  ForecastPropertiesTableViewCellConfigurator.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 30/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

struct ForecastPropertiesTableViewCellConfigurator {

    let fontProvider: FontProviding
    let colorProvider: ColorProviding
}

extension ForecastPropertiesTableViewCellConfigurator {

    func configure(
        cell: ForecastPropertiesTableViewCell,
        viewModel: ForecastPropertiesViewModel) {

        cell.backgroundColor = colorProvider.temperatureCellBackground
        cell.contentView.backgroundColor = colorProvider.temperatureCellBackground

        cell.stackView.spacing = 10

        cell.humidityIconLabel.font = fontProvider.humidityLabel()
        cell.humidityIconLabel.numberOfLines = 1
        cell.humidityIconLabel.textAlignment = .center
        cell.humidityIconLabel.text = viewModel.humidityIcon

        cell.humidityLabel.font = fontProvider.humidityLabel()
        cell.humidityLabel.textColor = colorProvider.humidityLabel
        cell.humidityLabel.numberOfLines = 0
        cell.humidityLabel.textAlignment = .center
        cell.humidityLabel.text = viewModel.humidity
        cell.humidityStackView.isHidden = viewModel.humidity.isEmpty

        cell.pressureIconLabel.font = fontProvider.pressureLabel()
        cell.pressureIconLabel.numberOfLines = 1
        cell.pressureIconLabel.textAlignment = .center
        cell.pressureIconLabel.text = viewModel.pressureIcon

        cell.pressureLabel.font = fontProvider.pressureLabel()
        cell.pressureLabel.textColor = colorProvider.pressureLabel
        cell.pressureLabel.numberOfLines = 0
        cell.pressureLabel.textAlignment = .center
        cell.pressureLabel.text = viewModel.pressure
        cell.pressureStackView.isHidden = viewModel.pressure.isEmpty

        cell.windSpeedIconLabel.font = fontProvider.windSpeedLabel()
        cell.windSpeedIconLabel.numberOfLines = 1
        cell.windSpeedIconLabel.textAlignment = .center
        cell.windSpeedIconLabel.text = viewModel.windSpeedIcon

        cell.windSpeedLabel.font = fontProvider.windSpeedLabel()
        cell.windSpeedLabel.textColor = colorProvider.windSpeedLabel
        cell.windSpeedLabel.numberOfLines = 0
        cell.windSpeedLabel.textAlignment = .center
        cell.windSpeedLabel.text = viewModel.windSpeed
        cell.windSpeedStackView.isHidden = viewModel.windSpeed.isEmpty
    }
}
