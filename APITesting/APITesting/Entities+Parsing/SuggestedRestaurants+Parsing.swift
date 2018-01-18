//
//  SuggestedRestaurants+Parsing.swift
//  APITesting
//
//  Created by Susmita Horrow on 18/01/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation
import Marshal

extension SuggestedRestaurants: Unmarshaling {
	init(object: MarshaledObject) throws {
		let suggestedData: [JSONObject] = try object.value(for: "groups")

		guard let firstData = suggestedData.first else {
			list = []
			return
		}
		let itemsData: [JSONObject] = try firstData.value(for: "items")
		list = try itemsData.flatMap { data in
			let restaurantData: JSONObject = try data.value(for: "venue")
			return try Restaurant(object: restaurantData)
		}
	}
}
