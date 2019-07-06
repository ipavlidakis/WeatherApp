//
//  SectionProtocol.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 02/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

protocol SectionProtocol {

    var isVisble: Bool { get }

    var numberOfItems: Int { get }

    func registerCells(on tableView: UITableView)

    func configureCell(
        on tableView: UITableView,
        indexPath: IndexPath) -> UITableViewCell

    func height(for row: Int) -> CGFloat

    func shouldHighlightRow(at row: Int) -> Bool

    func didSelectItem(at indexPath: IndexPath, on tableView: UITableView)
}

extension SectionProtocol {

    var isVisble: Bool { return true }

    var numberOfItems: Int { return 1 }

    func height(for row: Int) -> CGFloat { return UITableView.automaticDimension }

    func shouldHighlightRow(at row: Int) -> Bool { return true }

    func didSelectItem(at indexPath: IndexPath, on tableView: UITableView) {  }
}
