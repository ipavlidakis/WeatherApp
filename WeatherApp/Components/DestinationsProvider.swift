//
//  DestinationsProvider.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct DestinationsProvider {

    private let keyValueStore: KeyValueStoreProtocol
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private let store: ReduxMe.Store<AppState>
    private let queue: DispatchQueue

    private var disposableBag = ReduxMe.DisposableBag()
    private let key: String = "weather_app_list_destinations"

    init(keyValueStore: KeyValueStoreProtocol,
         encoder: JSONEncoder,
         decoder: JSONDecoder,
         store: ReduxMe.Store<AppState>,
         queue: DispatchQueue) {

        self.keyValueStore = keyValueStore
        self.encoder = encoder
        self.decoder = decoder
        self.store = store
        self.queue = queue

        store.dispatch(UpdateDestinations(destinations: fetchDestinations()))

        ReduxMe.Observable<AppState, DestinationsState>{ $0.destinationsState }
            .subscribe(on: store)
            .onChange(self.updatedDestinationsState)
            .disposed(by: disposableBag)
    }
}

private extension DestinationsProvider {

    func updatedDestinationsState(
        _ destinationsState: DestinationsState) {

        queue.async {
            self.persist(destinations: destinationsState.destinations)
        }
    }

    func fetchDestinations() -> [Destination] {

        guard
            let data = keyValueStore.data(forKey: key),
            let items = try? decoder.decode([Destination].self, from: data)
            else {  return [] }

        return items
    }

    func persist(destinations: [Destination]) {

        guard
            let data = try? encoder.encode(destinations)
            else { return }

        keyValueStore.set(data, forKey: key)
    }
}
