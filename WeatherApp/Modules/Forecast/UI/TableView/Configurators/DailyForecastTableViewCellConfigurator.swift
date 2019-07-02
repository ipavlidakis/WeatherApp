//
//  DailyForecastTableViewCellConfigurator.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 30/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

struct DailyForecastTableViewCellConfigurator {

    let fontProvider: FontProviding
    let colorProvider: ColorProviding
}

extension DailyForecastTableViewCellConfigurator {

    func configure(
        cell: DailyForecastTableViewCell,
        viewModel: DailyForecastViewModel) {

        cell.backgroundColor = colorProvider.dailyForecastCellBackground
        cell.contentView.backgroundColor = colorProvider.dailyForecastCellBackground

        cell.dayLabel.font = fontProvider.dayNameLabel()
        cell.dayLabel.textColor = colorProvider.dayNameLabel
        cell.dayLabel.numberOfLines = 0
        cell.dayLabel.textAlignment = .natural
        cell.dayLabel.text = viewModel.dayName

        cell.forecastIconLabel.font = fontProvider.dailyForecastIconLabel()
        cell.forecastIconLabel.textColor = colorProvider.dailyForeacastIconLabel
        cell.forecastIconLabel.numberOfLines = 0
        cell.forecastIconLabel.textAlignment = .center
        cell.forecastIconLabel.text = viewModel.icon

        cell.temperatureLabel.font = fontProvider.dailyForecastTemperatureLabel()
        cell.temperatureLabel.textColor = colorProvider.dailyForecastTemperatureLabel
        cell.temperatureLabel.numberOfLines = 0
        cell.temperatureLabel.textAlignment = .center
        cell.temperatureLabel.text = "\(viewModel.temperature) \(viewModel.unit)"
    }
}
