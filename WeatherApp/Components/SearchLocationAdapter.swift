//
//  SearchLocationAdapter.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit
import MapKit

final class SearchLocationAdapter: NSObject {

    enum State {

        case loading
        case loaded
    }

    private let searchCompleter: MKLocalSearchCompleter
    private let completionBlock: () -> Void

    private(set) var items: [(title: String, subtitle: String)] = []

    private(set) var state: State = .loaded {

        didSet { completionBlock() }
    }

    init(searchCompleter: MKLocalSearchCompleter,
         completionBlock: @escaping () -> Void) {

        self.searchCompleter = searchCompleter
        self.completionBlock = completionBlock

        super.init()

        searchCompleter.delegate = self
    }
}

extension SearchLocationAdapter: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        guard
            let text = searchController.searchBar.text,
            !text.isEmpty
        else {
            items = []
            state = .loaded
            return
        }

        if searchCompleter.isSearching {

            searchCompleter.cancel()
        }

        searchCompleter.queryFragment = text
        state = .loading
    }
}

extension SearchLocationAdapter: MKLocalSearchCompleterDelegate {

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {

        guard
            !completer.results.isEmpty,
            state == .loading
        else {
            items = []
            state = .loaded
            return
        }

        items = completer.results
            .map { (title: $0.title, subtitle: $0.subtitle) }
        state = .loaded
    }

    func completer(
        _ completer: MKLocalSearchCompleter,
        didFailWithError error: Error) {

        items = []
        state = .loaded
    }
}

extension SearchLocationAdapter {

    func fetchItem(
        at index: Int,
        completion: @escaping (_ result: Destination?) -> Void) {

        guard
            index >= 0,
            index < searchCompleter.results.count
        else {
            completion(nil)
            return
        }

        let item = searchCompleter.results[index]
        let searchRequest = MKLocalSearch.Request(completion: item)

        let search = MKLocalSearch(request: searchRequest)

        search.start { (response, error) in

            if error != nil {
                completion(nil)
                return
            }

            guard
                let itemResponse = response?.mapItems.first
            else {
                completion(nil)
                return
            }

            let destination = Destination(
                coordinates: Coordinates(latitude: itemResponse.placemark.coordinate.latitude, longitude: itemResponse.placemark.coordinate.latitude),
                name: "\(item.title), \(item.subtitle)",
                addedAt: Date())

            completion(destination)
        }
    }
}
