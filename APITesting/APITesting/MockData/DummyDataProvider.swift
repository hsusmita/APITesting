//
//  DummyDataProvider.swift
//  APITesting
//
//  Created by Susmita Horrow on 04/04/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation

protocol DummyDataProvider {
    static var dummyObject: Self { get }
    static var dummyCollection: [Self] { get }
}
