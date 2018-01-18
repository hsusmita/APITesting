//
//  Restaurant+Parsing.swift
//  APITesting
//
//  Created by Susmita Horrow on 18/01/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation
import Marshal

extension Restaurant: Unmarshaling {
	init(object: MarshaledObject) throws {
		id = try object.value(for: "id")
		name = try object.value(for: "name")
		let locationData: JSONObject = try object.value(for: "location")
		location = try Location(object: locationData)
		rating = try object.value(for: "rating")
		let priceData: JSONObject = try object.value(for: "price")
		price = try priceData.value(for: "tier")
		verified = try object.value(for: "verified")
	}
}
