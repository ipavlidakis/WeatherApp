//
//  NumberOfDaysTemperatureTableViewCellConfigurator.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 04/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

struct NumberOfDaysTemperatureTableViewCellConfigurator {

    let fontProvider: FontProviding
    let colorProvider: ColorProviding
}

extension NumberOfDaysTemperatureTableViewCellConfigurator {

    func configure(
        cell: NumberOfDaysTableViewCell,
        viewModel: NumberOfDaysCellViewModel) {

        cell.backgroundColor = colorProvider.numberOfDaysCellBackground
        cell.contentView.backgroundColor = colorProvider.numberOfDaysCellBackground

        cell.numberOfDaysLabel.font = fontProvider.numberOfDaysLabel()
        cell.numberOfDaysLabel.numberOfLines = 0
        cell.numberOfDaysLabel.textAlignment = .center
        cell.numberOfDaysLabel.text = viewModel.numberOfDays

        cell.separator.backgroundColor = colorProvider.numberOfDaysSeparator
    }
}
