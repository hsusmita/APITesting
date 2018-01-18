//
//  Location+Parsing.swift
//  APITesting
//
//  Created by Susmita Horrow on 18/01/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation
import Marshal

extension Location: Unmarshaling {
	init(object: MarshaledObject) throws {
		address = try object.value(for: "address")
		crossStreet = try object.value(for: "crossStreet")
		latitude = try object.value(for: "lat")
		longitude = try object.value(for: "lng")
		postalCode = try object.value(for: "postalCode")
		city = try object.value(for: "city")
		state = try object.value(for: "state")
		country = try object.value(for: "country")
		formattedAddress = try object.value(for: "formattedAddress") ?? []
	}
}
