//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 26/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import UIKit

final class ForecastViewController: UIViewController {

    private lazy var loadingIndicator = UIActivityIndicatorView(style: .white)
    private lazy var tableView: UITableView = UITableView()

    var store: ReduxMe.Store<AppState>!
    var forecastService: ForecastService!
    var tableViewAdapter: TableViewAdapter!
    var tableViewSectionsFactory: ForecastViewController.SectionsFactory!
    var colorProvider: ColorProviding!
    var router: Routing!
    private var disposableBag = ReduxMe.DisposableBag()
}

extension ForecastViewController {

    override func viewDidLoad() {

        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            customView: loadingIndicator)
        loadingIndicator.hidesWhenStopped = true

        configureNavigationController()
        configureToolbar()
        configureTableView()

        ReduxMe.Observable<AppState, CurrentLocationState>{ $0.currentLocation }
            .subscribe(on: store)
            .onChange(self.updatedCurrentLocationState)
            .disposed(by: disposableBag)

        ReduxMe.Observable<AppState, UnitsState>{ $0.unitsState }
            .subscribe(on: store)
            .onChange(self.updatedUnitsState)
            .disposed(by: disposableBag)
    }

    override func traitCollectionDidChange(
        _ previousTraitCollection: UITraitCollection?) {

        super.traitCollectionDidChange(previousTraitCollection)

        tableView.reloadData()
    }
}

extension ForecastViewController {

    func updatedCurrentLocationState(
        _ currentLocationState: CurrentLocationState) {

        self.title = currentLocationState.name

        configureLoading()

        forecastService.fetch(
        at: currentLocationState.coordinates,
        unit: store.state.unitsState.unit) { [weak self] (forecast, error) in

            if let error = error {

                let alertController = UIAlertController(
                    title: "Something went wrong".localized,
                    message: error.localizedDescription,
                    preferredStyle: .alert)

                alertController.addAction(
                    UIAlertAction(
                        title: "OK",
                        style: .default,
                        handler: nil))

                self?.present(alertController, animated: true, completion: nil)

                return
            }

            guard let forecast = forecast else { return }

            self?.configureLoaded(with: forecast)
        }
    }

    func updatedUnitsState(
        _ unitsState: UnitsState) {

        self.title = store.state.currentLocation.name

        configureLoading()

        forecastService.fetch(
            at: store.state.currentLocation.coordinates,
            unit: unitsState.unit) { [weak self] (forecast, error) in

                if let error = error {

                    let alertController = UIAlertController(
                        title: "Something went wrong".localized,
                        message: error.localizedDescription,
                        preferredStyle: .alert)

                    alertController.addAction(
                        UIAlertAction(
                            title: "OK",
                            style: .default,
                            handler: nil))

                    self?.present(alertController, animated: true, completion: nil)

                    return
                }

                guard let forecast = forecast else { return }

                self?.configureLoaded(with: forecast)
        }
    }

    @objc
    func navigateToList() {

        router.presentDestinationsList()
    }
}

private extension ForecastViewController {

    func configureNavigationController() {

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.setToolbarHidden(false, animated: true)
    }

    func configureToolbar() {

        self.toolbarItems = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(navigateToList))
        ]
    }

    func configureTableView() {

        tableView.backgroundColor = .clear
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
            sections: tableViewSectionsFactory.makeSections(for: nil),
            on: tableView)

        tableView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: navigationController?.toolbar.frame.height ?? 0,
            right: 0)
    }

    func configureLoaded(with forecast: Forecast) {

        loadingIndicator.stopAnimating()

        tableViewAdapter.update(
            sections: tableViewSectionsFactory.makeSections(for: forecast),
            on: tableView)

        guard let temperature = forecast.currently?.temperature else { return }

        configureColor(
            temperature: temperature,
            usesImperialUnits: forecast.flags.units == .us)
    }

    func configureLoading() {

        loadingIndicator.startAnimating()

        tableViewAdapter.update(
            sections: tableViewSectionsFactory.makeSections(for: nil),
            on: tableView)

        view.backgroundColor = .white
    }

    func configureColor(
        temperature: Float,
        usesImperialUnits: Bool) {

        guard usesImperialUnits else {

            switch temperature {
            case ..<0:
            view.backgroundColor = colorProvider.extremelyCold
            case 0..<5:
            view.backgroundColor = colorProvider.freezing
            case 5..<10:
            view.backgroundColor = colorProvider.cold
            case 10..<15:
            view.backgroundColor = colorProvider.chilly
            case 15..<20:
            view.backgroundColor = colorProvider.cool
            case 20..<25:
            view.backgroundColor = colorProvider.nice
            case 25..<30:
            view.backgroundColor = colorProvider.warm
            case 30..<35:
            view.backgroundColor = colorProvider.quiteHot
            case 35..<40:
                view.backgroundColor = colorProvider.hot
            default:
                view.backgroundColor = colorProvider.extremelyHot
            }

            return
        }

        switch temperature {
        case ..<32:
            view.backgroundColor = colorProvider.extremelyCold
        case 32..<41:
            view.backgroundColor = colorProvider.freezing
        case 41..<50:
            view.backgroundColor = colorProvider.cold
        case 50..<59:
            view.backgroundColor = colorProvider.chilly
        case 59..<68:
            view.backgroundColor = colorProvider.cool
        case 68..<77:
            view.backgroundColor = colorProvider.nice
        case 77..<86:
            view.backgroundColor = colorProvider.warm
        case 86..<95:
            view.backgroundColor = colorProvider.quiteHot
        case 95..<104:
            view.backgroundColor = colorProvider.hot
        default:
            view.backgroundColor = colorProvider.extremelyHot
        }
    }
}
