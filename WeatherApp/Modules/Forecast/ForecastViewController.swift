//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 26/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import UIKit

final class ForecastViewController: UIViewController {

    private lazy var loadingIndicator = UIActivityIndicatorView(style: .gray)
    private lazy var tableView: UITableView = UITableView()
    private lazy var infoMessageLabel: UILabel = UILabel()

    var store: ReduxMe.Store<AppState>!
    var forecastService: ForecastService!
    var tableViewAdapter: TableViewAdapter!
    var tableViewSectionsFactory: ForecastViewController.SectionsFactory!
    var colorProvider: ColorProviding!
    var destination: Destination!
    private var disposableBag = ReduxMe.DisposableBag()
}

extension ForecastViewController {

    override func viewDidLoad() {

        super.viewDidLoad()

        view.backgroundColor = .white
        loadingIndicator.hidesWhenStopped = true

        configureLoadingIndicator()
        configureNavigationController()
        configureTableView()
        configureInfoMessageLabel()

        ReduxMe.Observable<AppState, SettingsState>{ $0.settingsState }
            .subscribe(on: store)
            .onChange(self.updatedSettingsState)
            .disposed(by: disposableBag)


        configure(title: destination.name)
        if destination.isCurrentLocation {

            ReduxMe.Observable<AppState, CurrentLocationState>{ $0.currentLocation }
                .subscribe(on: store)
                .onChange(self.updatedCurrentLocationState)
                .manualTrigger()
                .disposed(by: disposableBag)
        } else {

            fetchForecast(
                for: destination.coordinates,
                unit: store.state.settingsState.unit)
        }
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

        guard currentLocationState.hasAccess else {

            configureForNoLocationAccess()
            return
        }

        configureForLocationAccessGranted()
        title = currentLocationState.name

        fetchForecast(
            for: currentLocationState.coordinates,
            unit: store.state.settingsState.unit)
    }

    func updatedSettingsState(
        _ settingsState: SettingsState) {

        self.title = store.state.currentLocation.name

        configureLoading()

        guard destination.isCurrentLocation else {

            fetchForecast(
                for: destination.coordinates,
                unit: settingsState.unit)
            return
        }

        fetchForecast(
            for: store.state.currentLocation.coordinates,
            unit: settingsState.unit)
    }
}

private extension ForecastViewController {

    func fetchForecast(for coordinates: Coordinates, unit: Units) {

        configureLoading()

        forecastService.fetch(
            at: coordinates,
            unit: unit) { [weak self] (forecast, error) in

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

    func configureLoadingIndicator() {

        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)

        [loadingIndicator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
         loadingIndicator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 8),
         loadingIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
         loadingIndicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8)]
            .forEach { $0.isActive = true }

        loadingIndicator.isHidden = true
        loadingIndicator.hidesWhenStopped = true
    }

    func configureInfoMessageLabel() {

        infoMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoMessageLabel)
        [infoMessageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
         infoMessageLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 8),
         infoMessageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
         infoMessageLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8)]
            .forEach { $0.isActive = true }

        infoMessageLabel.isHidden = true
        infoMessageLabel.numberOfLines = 0
        infoMessageLabel.textAlignment = .center
    }

    func configure(title: String) {

        navigationItem.title = title
    }

    func configureNavigationController() {

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
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
    }

    func configureLoaded(with forecast: Forecast) {

        loadingIndicator.stopAnimating()
        tableView.isHidden = false

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
        loadingIndicator.isHidden = false
        tableView.isHidden = true

        tableViewAdapter.update(
            sections: tableViewSectionsFactory.makeSections(for: nil),
            on: tableView)

        view.backgroundColor = .white
    }

    func configureColor(
        temperature: Float,
        usesImperialUnits: Bool) {

        UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {

            guard usesImperialUnits else {

                switch temperature {
                case ..<0:
                    self.view.backgroundColor = self.colorProvider.extremelyCold
                case 0..<5:
                    self.view.backgroundColor = self.colorProvider.freezing
                case 5..<10:
                    self.view.backgroundColor = self.colorProvider.cold
                case 10..<15:
                    self.view.backgroundColor = self.colorProvider.chilly
                case 15..<20:
                    self.view.backgroundColor = self.colorProvider.cool
                case 20..<25:
                    self.view.backgroundColor = self.colorProvider.nice
                case 25..<30:
                    self.view.backgroundColor = self.colorProvider.warm
                case 30..<35:
                    self.view.backgroundColor = self.colorProvider.quiteHot
                case 35..<40:
                    self.view.backgroundColor = self.colorProvider.hot
                default:
                    self.view.backgroundColor = self.colorProvider.extremelyHot
                }

                return
            }

            switch temperature {
            case ..<32:
                self.view.backgroundColor = self.colorProvider.extremelyCold
            case 32..<41:
                self.view.backgroundColor = self.colorProvider.freezing
            case 41..<50:
                self.view.backgroundColor = self.colorProvider.cold
            case 50..<59:
                self.view.backgroundColor = self.colorProvider.chilly
            case 59..<68:
                self.view.backgroundColor = self.colorProvider.cool
            case 68..<77:
                self.view.backgroundColor = self.colorProvider.nice
            case 77..<86:
                self.view.backgroundColor = self.colorProvider.warm
            case 86..<95:
                self.view.backgroundColor = self.colorProvider.quiteHot
            case 95..<104:
                self.view.backgroundColor = self.colorProvider.hot
            default:
                self.view.backgroundColor = self.colorProvider.extremelyHot
            }
            }.startAnimation()
    }

    func configureForNoLocationAccess() {

        UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {

            self.view.backgroundColor = self.colorProvider.noLocationAccessBackground
            self.tableView.isHidden = true

            self.infoMessageLabel.text = "Please enable access in settings"
            self.infoMessageLabel.isHidden = false
        }.startAnimation()
    }

    func configureForLocationAccessGranted() {

        UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            self.view.backgroundColor = self.colorProvider.noLocationAccessBackground
            self.tableView.isHidden = false

            self.infoMessageLabel.isHidden = true
        }.startAnimation()
    }
}
