//
//  RestaurantStats+Parsing.swift
//  APITesting
//
//  Created by Susmita Horrow on 18/01/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation
import Marshal

extension RestaurantStats: Unmarshaling {
	init(object: MarshaledObject) throws {
		checkinsCount = try object.value(for: "checkinsCount")
		usersCount = try object.value(for: "usersCount")
		tipCount = try object.value(for: "tipCount")
		visitsCount = try object.value(for: "visitsCount")
	}
}
