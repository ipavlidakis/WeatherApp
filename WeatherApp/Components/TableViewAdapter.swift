//
//  TableViewAdapter.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 30/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

final class TableViewAdapter: NSObject {

    private var sections: [SectionProtocol] = []
}

extension TableViewAdapter: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {

        return sections.filter { $0.isVisble }.count
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {

        return sections[section].numberOfItems
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return sections[indexPath.section]
            .configureCell(on: tableView, indexPath: indexPath)
    }
}

extension TableViewAdapter: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {

        return sections[indexPath.section].didSelectItem(
            at: indexPath,
            on: tableView)
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath) -> CGFloat {

        return sections[indexPath.section].height(for: indexPath.row)
    }

    func tableView(
        _ tableView: UITableView,
        shouldHighlightRowAt indexPath: IndexPath) -> Bool {

        return sections[indexPath.section].shouldHighlightRow(at: indexPath.row)
    }
}

extension TableViewAdapter {

    func update(
        sections: [SectionProtocol],
        on tableView: UITableView) {

        self.sections = sections

        registerCells(on: tableView)

        tableView.reloadData()
    }

    func registerCells(
        on tableView: UITableView) {

        sections.forEach { $0.registerCells(on: tableView) }
    }
}
