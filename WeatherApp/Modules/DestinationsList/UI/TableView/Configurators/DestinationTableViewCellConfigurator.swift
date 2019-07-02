//
//  DestinationTableViewCellConfigurator.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

struct DestinationTableViewCellConfigurator {

    let fontProvider: FontProviding
    let colorProvider: ColorProviding
}

extension DestinationTableViewCellConfigurator {

    func configure(
        cell: DestinationTableViewCell,
        title: String,
        subtitle: String) {

        cell.backgroundColor = colorProvider.destinationCellBackground
        cell.contentView.backgroundColor = colorProvider.destinationCellBackground

        cell.titleLabel.font = fontProvider.destinationTitleLabel()
        cell.titleLabel.textColor = colorProvider.destinationTitleLabel
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.textAlignment = .natural
        cell.titleLabel.text = title

        cell.subtitleLabel.font = fontProvider.destinationSubTitleLabel()
        cell.subtitleLabel.textColor = colorProvider.destinationSubTitleLabel
        cell.subtitleLabel.numberOfLines = 0
        cell.subtitleLabel.textAlignment = .natural
        cell.subtitleLabel.text = subtitle
    }
}
