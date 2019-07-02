//
//  ForecastPropertiesTableViewCell.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 30/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import UIKit

final class ForecastPropertiesTableViewCell: UITableViewCell {

    @IBOutlet var stackView: UIStackView!
    @IBOutlet var humidityStackView: UIStackView!
    @IBOutlet var humidityIconLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var pressureStackView: UIStackView!
    @IBOutlet var pressureIconLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var windSpeedStackView: UIStackView!
    @IBOutlet var windSpeedIconLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
}
