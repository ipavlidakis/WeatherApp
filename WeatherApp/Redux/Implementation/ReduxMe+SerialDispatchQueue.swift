//
//  SerialDispatchQueue.swift
//  ReduxMe
//
//  Created by Ilias Pavlidakis on 08/02/2019.
//  Copyright © 2019 ReduxMe All rights reserved.
//

import Foundation

public extension ReduxMe {

    final class SerialDispatchQueue: OperationQueue {

        public override init() {
            super.init()

            self.name = "SerialDispatchQueue"
            self.maxConcurrentOperationCount = 1
        }
    }
}
extension ReduxMe.SerialDispatchQueue: ReduxMeSerialDispatchQueueing {

    public func enqueue(_ block: @escaping () -> Void) {
        
        self.addOperation(block)
    }
    
    public func clear() {
        
        self.cancelAllOperations()
    }
}
