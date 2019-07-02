//
//  SerialDispatchQueueing.swift
//  ReduxMe
//
//  Created by Ilias Pavlidakis on 01/06/2019.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

public protocol ReduxMeSerialDispatchQueueing {

    func enqueue(_ block: @escaping () -> Void)

    func clear()
}
