//
//  SingleDestinationTableViewCellConfigurator.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

struct SingleDestinationTableViewCellConfigurator {

    let fontProvider: FontProviding
    let colorProvider: ColorProviding
}

extension SingleDestinationTableViewCellConfigurator {

    func configure(
        cell: SingleDestinationTableViewCell,
        title: String,
        subtitle: String) {

        cell.backgroundColor = colorProvider.singleDestinationCellBackground
        cell.contentView.backgroundColor = colorProvider.singleDestinationCellBackground

        cell.titleLabel.font = fontProvider.singleDestinationTitleLabel()
        cell.titleLabel.textColor = colorProvider.singleDestinationTitleLabel
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.textAlignment = .natural
        cell.titleLabel.text = title

        cell.subtitleLabel.font = fontProvider.singleDestinationSubTitleLabel()
        cell.subtitleLabel.textColor = colorProvider.singleDestinationSubTitleLabel
        cell.subtitleLabel.numberOfLines = 0
        cell.subtitleLabel.textAlignment = .natural
        cell.subtitleLabel.text = subtitle

        cell.activityIndicator.hidesWhenStopped = true
        cell.activityIndicator.color = .gray
        cell.activityIndicator.stopAnimating()
    }

    func configureForLoading(
        cell: SingleDestinationTableViewCell,
        title: String,
        subtitle: String) {

        cell.backgroundColor = colorProvider.singleDestinationCellBackground
        cell.contentView.backgroundColor = colorProvider.singleDestinationCellBackground

        cell.titleLabel.font = fontProvider.singleDestinationTitleLabel()
        cell.titleLabel.textColor = colorProvider.singleDestinationTitleLabel
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.textAlignment = .natural
        cell.titleLabel.text = title

        cell.subtitleLabel.font = fontProvider.singleDestinationSubTitleLabel()
        cell.subtitleLabel.textColor = colorProvider.singleDestinationSubTitleLabel
        cell.subtitleLabel.numberOfLines = 0
        cell.subtitleLabel.textAlignment = .natural
        cell.subtitleLabel.text = subtitle

        cell.activityIndicator.hidesWhenStopped = true
        cell.activityIndicator.color = .gray
        cell.activityIndicator.startAnimating()
    }

}
