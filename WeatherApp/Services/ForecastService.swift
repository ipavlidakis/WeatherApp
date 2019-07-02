//
//  ForecastService.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 25/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct ForecastService {

    private let session: URLSession
    private let baseURL: URL
    private let apiKey: String
    private let dispatchQueue: DispatchQueue

    init(session: URLSession = .shared,
         baseURL: URL = URL(string: "https://api.darksky.net")!,
         apiKey: String = "b1071a70d34f6e473eae0277c789e647",
         dispatchQueue: DispatchQueue = .main) {

        self.session = session
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.dispatchQueue = dispatchQueue
    }
}

extension ForecastService {

    func fetch(
        at coordinates: Coordinates,
        unit: Units,
        completionBlock: @escaping (Forecast?, Error?) -> Void) {

        let endpoint = baseURL
            .appendingPathComponent("forecast")
            .appendingPathComponent(apiKey)
            .appendingPathComponent(coordinates.description)

        guard var urlComponents = URLComponents(url: endpoint, resolvingAgainstBaseURL: false) else {
            fatalError("Failed to decompose url \(endpoint) to URLComponents")
        }

        urlComponents.queryItems = [URLQueryItem(name: "units", value: unit.rawValue)]

        guard let url = urlComponents.url else {
            fatalError("Failed to compose url from URLComponents")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Accept-Encoding": "gzip",
            "Content-Type": "application/json"
        ]

        let dispatchQueueToUse = dispatchQueue

        let task = session.dataTask(with: request) { (data, _, error) in

            if let error = error {
                dispatchQueueToUse.async {
                    completionBlock(nil, AppError.custom(error))
                }
                return
            }

            guard
                let data = data
            else {
                dispatchQueueToUse.async {
                    completionBlock(nil, AppError.noData)
                }
                return
            }

            do {
                let result = try JSONDecoder().decode(Forecast.self, from: data)
                dispatchQueueToUse.async {
                    completionBlock(result, nil)
                }
            } catch(let exception) {
                dispatchQueueToUse.async {
                    completionBlock(nil, AppError.custom(exception))
                }
            }
        }

        task.resume()
    }
}
