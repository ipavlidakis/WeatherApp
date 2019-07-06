//
//  Disposable.swift
//  ReduxMe
//
//  Created by Ilias Pavlidakis on 3/5/19.
//  Copyright © 2019 ReduxMe All rights reserved.
//

import Foundation

public protocol ReduxMeDisposable: class {

    func onDispose()
}
