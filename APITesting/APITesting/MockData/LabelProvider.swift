//
//  LabelProvider.swift
//  APITesting
//
//  Created by Susmita Horrow on 04/04/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation

protocol LabelProvider {
    var label: String { get }
}

extension LabelProvider {
    var label: String {
        let mirror = Mirror(reflecting: self)
        if let label = mirror.children.first?.label {
            return label
        } else {
            return String(describing: self)
        }
    }
}
