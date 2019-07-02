//
//  AddNewDestinationViewController.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit
import MapKit

final class AddNewDestinationViewController: UIViewController {

    private lazy var tableView: UITableView = UITableView()

    var store: ReduxMe.Store<AppState>!
    var tableViewAdapter: TableViewAdapter!
    var tableViewSectionsFactory: AddNewDestinationViewController.SectionsFactory!
    var searchLocationAdapter: SearchLocationAdapter!

    private var disposableBag = ReduxMe.DisposableBag()
}

extension AddNewDestinationViewController {

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "Add Destination".localized

        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = searchLocationAdapter
        navigationItem.hidesSearchBarWhenScrolling = false
        search.definesPresentationContext = true
        search.obscuresBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = false

        navigationItem.searchController = search

        view.backgroundColor = .white
        configureTableView()

        ReduxMe.Observable<AppState, DestinationsState>{ $0.destinationsState }
            .subscribe(on: store)
            .onChange(self.updatedDestinationsState)
            .disposed(by: disposableBag)
    }

    override func traitCollectionDidChange(
        _ previousTraitCollection: UITraitCollection?) {

        super.traitCollectionDidChange(previousTraitCollection)

        tableView.reloadData()
    }

    func resultsUpdated() {

        tableViewAdapter.update(
            sections: tableViewSectionsFactory.makeSections(),
            on: tableView)
    }
}

extension AddNewDestinationViewController {

    func updatedDestinationsState(
        _ destinationsState: DestinationsState) {

        navigationController?.popViewController(animated: true)
    }
}

private extension AddNewDestinationViewController {

    func configureTableView() {

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        [tableView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
         tableView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
         tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)]
            .forEach { $0.isActive = true }

        tableView.dataSource = tableViewAdapter
        tableView.delegate = tableViewAdapter
        tableView.separatorStyle = .none

        tableViewAdapter.update(
            sections: tableViewSectionsFactory.makeSections(),
            on: tableView)
    }
}

