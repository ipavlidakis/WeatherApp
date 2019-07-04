//
//  ColorProvider.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 30/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

protocol ColorProviding {

    // MARK: TemperatureTableViewCell

    var temperatureCellBackground: UIColor { get }
    var temperatureDescription: UIColor { get }
    var temperatureLabel: UIColor { get }

    // MARK: ForecastPropertiesTableViewCell

    var forecastPropertiesCellBackground: UIColor { get }
    var humidityLabel: UIColor { get }
    var pressureLabel: UIColor { get }
    var windSpeedLabel: UIColor { get }

    // MARK: DailyForecastTableViewCell

    var dailyForecastCellBackground: UIColor { get }
    var dayNameLabel: UIColor { get }
    var dailyForeacastIconLabel: UIColor { get }
    var dailyForecastTemperatureLabel: UIColor { get }

    // MARK: Temperatures

    var extremelyCold: UIColor { get }
    var freezing: UIColor { get }
    var cold: UIColor { get }
    var chilly: UIColor { get }
    var cool: UIColor { get }
    var nice: UIColor { get }
    var warm: UIColor { get }
    var quiteHot: UIColor { get }
    var hot: UIColor { get }
    var extremelyHot: UIColor { get }

    // MARK: NumberOfDaysTableViewCell

    var numberOfDaysCellBackground: UIColor { get }
    var numberOfDaysLabel: UIColor { get }
    var numberOfDaysSeparator: UIColor { get }

    // MARK: NoDestinations

    var noDestinationsCellBackground: UIColor { get }
    var noDestinationsTitleLabel: UIColor { get }
    var noDestinationsSubTitleLabel: UIColor { get }

    // MARK: Destination

    var destinationCellBackground: UIColor { get }
    var destinationTitleLabel: UIColor { get }
    var destinationSubTitleLabel: UIColor { get }

    // MARK: Single Destination

    var singleDestinationCellBackground: UIColor { get }
    var singleDestinationTitleLabel: UIColor { get }
    var singleDestinationSubTitleLabel: UIColor { get }

    // MARK: AddDestinations Loading

    var addDestinationsLoadingCellBackground: UIColor { get }
    var addDestinationsLoadingTitleLabel: UIColor { get }

    // MARK: ForecastViewController

    var noLocationAccessBackground: UIColor { get }
}

struct ColorProvider: ColorProviding {

    // MARK: TemperatureTableViewCell
    
    var temperatureCellBackground: UIColor = .clear
    var temperatureDescription: UIColor = .black
    var temperatureLabel: UIColor = .black

    // MARK: ForecastPropertiesTableViewCell

    var forecastPropertiesCellBackground: UIColor = .clear
    var humidityLabel: UIColor = .black
    var pressureLabel: UIColor = .black
    var windSpeedLabel: UIColor = .black

    // MARK: DailyForecastTableViewCell

    var dailyForecastCellBackground: UIColor = .clear
    var dayNameLabel: UIColor = .black
    var dailyForeacastIconLabel: UIColor = .black
    var dailyForecastTemperatureLabel: UIColor = .black

    // MARK: NumberOfDaysTableViewCell

    var numberOfDaysCellBackground: UIColor = .clear
    var numberOfDaysLabel: UIColor = .black
    var numberOfDaysSeparator: UIColor = .gray

    // MARK: Temperatures

    var extremelyCold: UIColor = UIColor(red: 7 / 255, green: 0 / 255, blue: 129 / 255, alpha: 1)
    var freezing: UIColor = .blue
    var cold: UIColor = UIColor(red: 54 / 255, green: 99 / 255, blue: 247 / 255, alpha: 1)
    var chilly: UIColor = UIColor(red: 155 / 255, green: 206 / 255, blue: 253 / 255, alpha: 1)
    var cool: UIColor = UIColor(red: 57 / 255, green: 208 / 255, blue: 205 / 255, alpha: 1)
    var nice: UIColor = .green
    var warm: UIColor = UIColor(red: 153 / 255, green: 208 / 255, blue: 34 / 255, alpha: 1)
    var quiteHot: UIColor = UIColor(red: 250 / 255, green: 211 / 255, blue: 33 / 255, alpha: 1)
    var hot: UIColor = .orange
    var extremelyHot: UIColor = .red

    // MARK: NoDestinations

    var noDestinationsCellBackground: UIColor = .clear
    var noDestinationsTitleLabel: UIColor = .black
    var noDestinationsSubTitleLabel: UIColor = .gray

    // MARK: Destination

    var destinationCellBackground: UIColor = .clear
    var destinationTitleLabel: UIColor = .black
    var destinationSubTitleLabel: UIColor = .gray

    // MARK: Single Destination

    var singleDestinationCellBackground: UIColor = .clear
    var singleDestinationTitleLabel: UIColor = .black
    var singleDestinationSubTitleLabel: UIColor = .gray

    // MARK: AddDestinations Loading

    var addDestinationsLoadingCellBackground: UIColor = .clear
    var addDestinationsLoadingTitleLabel: UIColor = .gray

    // MARK: ForecastViewController

    var noLocationAccessBackground: UIColor = .white
}
