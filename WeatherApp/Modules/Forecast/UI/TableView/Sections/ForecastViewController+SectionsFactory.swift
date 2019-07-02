//
//  ForecastViewController+SectionsFactory.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 30/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

extension ForecastViewController {

    struct SectionsFactory {

        let fontProvider: FontProviding
        let colorProvider: ColorProviding

        func makeSections(for forecast: Forecast?) -> [SectionProtocol] {

            guard let forecast = forecast else { return [] }

            var sections = [SectionProtocol?]()

            sections.append(addTemperatureSection(forecast: forecast))
            sections.append(addForecastPropertiesSection(forecast: forecast))
            sections.append(addDailyForecastSection(forecast: forecast))

            return sections.compactMap { $0 }
        }
    }
}

extension ForecastViewController.SectionsFactory {

    func addTemperatureSection(
        forecast: Forecast) -> SectionProtocol? {

        guard let currently = forecast.currently else { return nil }

        let configurator = TemperatureTableViewCellConfigurator(
            fontProvider: fontProvider,
            colorProvider: colorProvider)

        let temperature: String = {

            guard let temperature = currently.temperature else { return "-" }

            let numberFormatter = NumberFormatter()
            numberFormatter.generatesDecimalNumbers = false

            return numberFormatter.string(
                from: NSNumber(value: round(temperature))) ?? "-"
        }()

        let viewModel = TemperatureCellViewModel(
            icon: currently.icon?.icon ?? "-",
            temperatureDescription: currently.summary ?? "-",
            temperature: temperature,
            unit: forecast.flags.units.measurementUnits.temperature)

        return ForecastViewController.TemperatureSection(
            configurator: configurator,
            viewModel: viewModel)
    }

    func addForecastPropertiesSection(
        forecast: Forecast) -> SectionProtocol?  {

        let configurator = ForecastPropertiesTableViewCellConfigurator(
            fontProvider: fontProvider,
            colorProvider: colorProvider)

        guard
            let currently = forecast.currently,
            currently.humidity != nil || currently.pressure != nil || currently.windSpeed != nil
        else { return nil }

        let stringGeneration: (_ value: Float?, _ unit: String, _ defaultValue: String) -> String = { value, unit, defaultValue in

            guard let value = value else { return defaultValue }

            let numberFormatter = NumberFormatter()
            numberFormatter.generatesDecimalNumbers = false

            guard
                let stringValue = numberFormatter.string(from: NSNumber(value: round(value)))
            else { return defaultValue }

            return "\(stringValue) \(unit)"
        }

        let humidityPercentage: String = {

            guard let humidity = currently.humidity else { return "" }

            let numberFormatter = NumberFormatter()
            numberFormatter.generatesDecimalNumbers = false
            numberFormatter.numberStyle = .percent

            return numberFormatter.string(from: NSNumber(value: humidity)) ?? "-"
        }()

        let viewModel = ForecastPropertiesViewModel(
            humidityIcon: "💧",
            humidity: humidityPercentage,
            pressureIcon: "🌡",
            pressure: stringGeneration(currently.pressure, forecast.flags.units.measurementUnits.pressure, ""),
            windSpeedIcon: "🌬",
            windSpeed: stringGeneration(currently.windSpeed, forecast.flags.units.measurementUnits.windSpeed, ""))

        return ForecastViewController.ForecastPropertiesSection(
            configurator: configurator,
            viewModel: viewModel)
    }

    func addDailyForecastSection(
        forecast: Forecast) -> SectionProtocol? {

        let configurator = DailyForecastTableViewCellConfigurator(
            fontProvider: fontProvider,
            colorProvider: colorProvider)

        guard let dailyForecasts = forecast.daily?.data else { return nil }

        let viewModels: [DailyForecastViewModel] = dailyForecasts.map {

            let date = Date(timeIntervalSince1970: $0.time)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE"
            let dayInWeek = dateFormatter.string(from: date)

            return DailyForecastViewModel(
                dayName: dayInWeek,
                icon: $0.icon?.icon ?? "-",
                temperature: $0.temperatureHigh?.description ?? "-",
                unit: forecast.flags.units.measurementUnits.temperatureMax)
        }

        return ForecastViewController.DailyForecastSection(
            configurator: configurator,
            viewModels: viewModels)
    }
}
