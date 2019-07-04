//
//  FontProvider.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 30/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

protocol FontProviding {

    // MARK: TemperatureTableViewCell

    func temperatureIcon() -> UIFont
    func temperatureDescription() -> UIFont
    func temperatureLabel() -> UIFont

    // MARK: ForecastPropertiesTableViewCell

    func humidityLabel() -> UIFont
    func pressureLabel() -> UIFont
    func windSpeedLabel() -> UIFont

    // MARK: DailyForecastTableViewCell

    func dayNameLabel() -> UIFont
    func dailyForecastIconLabel() -> UIFont
    func dailyForecastTemperatureLabel() -> UIFont

    // MARK: NumberOfDaysTableViewCell

    func numberOfDaysLabel() -> UIFont

    // MARK: NoDestinations

    func noDestinationsTitleLabel() -> UIFont
    func noDestinationsSubTitleLabel() -> UIFont

    // MARK: Destination

    func destinationTitleLabel() -> UIFont
    func destinationSubTitleLabel() -> UIFont

    // MARK: Single Destination

    func singleDestinationTitleLabel() -> UIFont
    func singleDestinationSubTitleLabel() -> UIFont

    // MARK: AddDestinations Loading

    func addDestinationsLoadingTitleLabel() -> UIFont
}

struct FontProvider: FontProviding {

    // MARK: TemperatureTableViewCell

    func temperatureIcon() -> UIFont {

        return UIFont.systemFont(ofSize: 130)
    }

    func temperatureDescription() -> UIFont {

        return UIFont.preferredFont(forTextStyle: .title3)
    }

    func temperatureLabel() -> UIFont {

        return UIFont.preferredFont(forTextStyle: .title1)
    }

    // MARK: ForecastPropertiesTableViewCell

    func humidityLabel() -> UIFont {

        return UIFont.preferredFont(forTextStyle: .title3)
    }

    func pressureLabel() -> UIFont {

        return UIFont.preferredFont(forTextStyle: .title3)
    }

    func windSpeedLabel() -> UIFont {

        return UIFont.preferredFont(forTextStyle: .title3)
    }

    // MARK: DailyForecastTableViewCell

    func dayNameLabel() -> UIFont {

        return UIFont.preferredFont(forTextStyle: .title3)
    }

    func dailyForecastIconLabel() -> UIFont {

        return UIFont.preferredFont(forTextStyle: .title3)
    }

    func dailyForecastTemperatureLabel() -> UIFont {

        return UIFont.preferredFont(forTextStyle: .title3)
    }

    // MARK: NumberOfDaysTableViewCell

    func numberOfDaysLabel() -> UIFont {

        return UIFont.preferredFont(forTextStyle: .body)
    }

    // MARK: NoDestinations

    func noDestinationsTitleLabel() -> UIFont {

        return UIFont.preferredFont(forTextStyle: .body)
    }

    func noDestinationsSubTitleLabel() -> UIFont {

        return UIFont.preferredFont(forTextStyle: .caption1)
    }

    // MARK: Destination

    func destinationTitleLabel() -> UIFont {

        return UIFont.preferredFont(forTextStyle: .body)
    }

    func destinationSubTitleLabel() -> UIFont {

        return UIFont.preferredFont(forTextStyle: .caption1)
    }

    // MARK: Single Destination

    func singleDestinationTitleLabel() -> UIFont {

        return UIFont.preferredFont(forTextStyle: .body)
    }

    func singleDestinationSubTitleLabel() -> UIFont {

        return UIFont.preferredFont(forTextStyle: .caption1)
    }

    // MARK: AddDestinations Loading

    func addDestinationsLoadingTitleLabel() -> UIFont {

        return UIFont.preferredFont(forTextStyle: .body)
    }
}
