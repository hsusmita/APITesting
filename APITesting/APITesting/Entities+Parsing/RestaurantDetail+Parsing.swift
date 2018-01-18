//
//  RestaurantDetail+Parsing.swift
//  APITesting
//
//  Created by Susmita Horrow on 18/01/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation
import Marshal

extension RestaurantDetail: Unmarshaling {
	init(object: MarshaledObject) throws {
		let restaurantData: JSONObject = try object.value(for: "venue")
		restaurant = try Restaurant(object: restaurantData)
		stats = try restaurantData.value(for: "stats")
		let likeData: JSONObject = try restaurantData.value(for: "likes")
		likeCount = try likeData.value(for: "count")
	}
}
