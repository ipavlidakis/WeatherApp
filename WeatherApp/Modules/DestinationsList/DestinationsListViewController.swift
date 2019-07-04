//
//  DestinationsListViewController.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

final class DestinationsListViewController: UIViewController {

    private lazy var tableView: UITableView = UITableView()
    private var hasAuthorizedLocationServices = false

    var store: ReduxMe.Store<AppState>!
    var tableViewAdapter: TableViewAdapter!
    var tableViewSectionsFactory: DestinationsListViewController.SectionsFactory!
    var router: Routing!

    private var disposableBag = ReduxMe.DisposableBag()
}

extension DestinationsListViewController {

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "Destinations".localized
        view.backgroundColor = .white

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewDestination))

        configureTableView()

        ReduxMe.Observable<AppState, DestinationsState>{ $0.destinationsState }
            .subscribe(on: store)
            .onChange(self.updatedDestinationsState)
            .disposed(by: disposableBag)

        ReduxMe.Observable<AppState, CurrentLocationState>{ $0.currentLocation }
            .subscribe(on: store)
            .onChange(self.updatedLocationState)
            .disposed(by: disposableBag)
    }

    override func traitCollectionDidChange(
        _ previousTraitCollection: UITraitCollection?) {

        super.traitCollectionDidChange(previousTraitCollection)

        tableView.reloadData()
    }
}

extension DestinationsListViewController {

    @objc
    func addNewDestination() {

        router.pushAddNewDestination()
    }

    func updatedDestinationsState(
        _ destinationsState: DestinationsState) {

        tableViewAdapter.update(
            sections: tableViewSectionsFactory.makeSections(),
            on: tableView)
    }

    func updatedLocationState(
        _ destinationsState: CurrentLocationState) {

        guard destinationsState.hasAccess != hasAuthorizedLocationServices else {
            return
        }

        hasAuthorizedLocationServices = destinationsState.hasAccess

        tableViewAdapter.update(
            sections: tableViewSectionsFactory.makeSections(),
            on: tableView)
    }
}

private extension DestinationsListViewController {

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
