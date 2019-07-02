//
//  AddDestinationsLoadingTableViewCellConfigurator.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

struct AddDestinationsLoadingTableViewCellConfigurator {

    let fontProvider: FontProviding
    let colorProvider: ColorProviding
}

extension AddDestinationsLoadingTableViewCellConfigurator {

    func configure(
        cell: AddDestinationsLoadingTableViewCell,
        title: String) {

        cell.backgroundColor = colorProvider.addDestinationsLoadingCellBackground
        cell.contentView.backgroundColor = colorProvider.addDestinationsLoadingCellBackground

        cell.titleLabel.font = fontProvider.addDestinationsLoadingTitleLabel()
        cell.titleLabel.textColor = colorProvider.addDestinationsLoadingTitleLabel
        cell.titleLabel.numberOfLines = 1
        cell.titleLabel.textAlignment = .natural
        cell.titleLabel.text = title

        cell.activityIndicator.color = .gray
        cell.activityIndicator.hidesWhenStopped = true
        cell.activityIndicator.startAnimating()
    }
}
