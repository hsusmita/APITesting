//
//  Resource.swift
//  APITesting
//
//  Created by Susmita Horrow on 18/01/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation
import Marshal

struct Resource<Value> {
	let requestRouter: RequestRouterProtocol
	let parse: (JSONObject) throws -> Value
}

extension Resource where Value: Unmarshaling {
	init(requestRouter: RequestRouterProtocol) {
		self.init(requestRouter: requestRouter,
				  parse: { jsonObject in
					return try jsonObject.value(for: "response")
		})
	}
}

extension Resource where Value: Collection, Value.Element: Unmarshaling {
	init(requestRouter: RequestRouterProtocol) {
		self.init(requestRouter: requestRouter,
				  parse: { jsonObject in
					let objects: [Value.Element] = try jsonObject.value(for: "response")
					return objects as! Value
		})
	}
}
