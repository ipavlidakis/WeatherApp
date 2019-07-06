//
//  KeyValueStoreProtocol.swift
//  WeatherApp
//
//  Created by Ilias Pavlidakis on 01/07/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

protocol KeyValueStoreProtocol {

    func bool(forKey: String) -> Bool

    func integer(forKey: String) -> Int

    func data(forKey: String) -> Data?

    func set(_ value: Any?, forKey defaultName: String)
}
