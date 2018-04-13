//
//  Tracker.swift
//  APITesting
//
//  Created by Susmita Horrow on 04/04/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation

class Tracker<T> {
    private(set) var elements: [T] = []
    
    func track(_ element: T) {
        elements.append(element)
    }
    
    func reset() {
        elements.removeAll()
    }
}
