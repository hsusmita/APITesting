//
//  Location.swift
//  APITesting
//
//  Created by Susmita Horrow on 18/01/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation

struct Location {
	let address: String?
	let crossStreet: String?
	let latitude: Double
	let longitude: Double
	let postalCode: String?
	let city: String?
	let state: String?
	let country: String?
	let formattedAddress: [String]
}
