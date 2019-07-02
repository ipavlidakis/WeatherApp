//
//  NoDestinationsTableViewCellConfigurator.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

struct NoDestinationsTableViewCellConfigurator {

    let fontProvider: FontProviding
    let colorProvider: ColorProviding
}

extension NoDestinationsTableViewCellConfigurator {

    func configure(
        cell: NoDestinationsTableViewCell,
        title: String,
        subtitle: String) {

        cell.backgroundColor = colorProvider.noDestinationsCellBackground
        cell.contentView.backgroundColor = colorProvider.noDestinationsCellBackground

        cell.titleLabel.font = fontProvider.noDestinationsTitleLabel()
        cell.titleLabel.textColor = colorProvider.noDestinationsTitleLabel
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.textAlignment = .center
        cell.titleLabel.text = title

        cell.subtitleLabel.font = fontProvider.noDestinationsSubTitleLabel()
        cell.subtitleLabel.textColor = colorProvider.noDestinationsSubTitleLabel
        cell.subtitleLabel.numberOfLines = 0
        cell.subtitleLabel.textAlignment = .center
        cell.subtitleLabel.text = subtitle
    }
}
