//
//  Error.swift
//  APITesting
//
//  Created by Susmita Horrow on 18/01/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation
import Marshal

public struct AnyError: Swift.Error {
	public let baseError: Swift.Error

	public init(_ error: Swift.Error) {
		if let anyError = error as? AnyError {
			self = anyError
		} else {
			self.baseError = error
		}
	}
}

protocol ApplicationError: LocalizedError {
	var title: String { get }
	var debugDescription: String { get }
}

struct InternetError: ApplicationError {
	var title: String {
		return "No Internet!"
	}

	var debugDescription: String {
		return "Internet not working"
	}

	var errorDescription: String? {
		return "Internet seems to be down. Please try again after reconnecting!"
	}
}

struct ParsingError: ApplicationError {
	let error: MarshalError

	init(error: MarshalError) {
		self.error = error
	}

	var title: String {
		return "Error"
	}

	var debugDescription: String {
		return "Parsing Error: \(error.description)"
	}

	var errorDescription: String? {
		return "Something went wrong. Try again!"
	}
}

struct ServerError: ApplicationError {
	var message: String

	init(message: String) {
		self.message = message
	}

	var title: String {
		return "Server Error"
	}

	var debugDescription: String {
		return "Server Error: \(message)"
	}

	var errorDescription: String? {
		return "Something went wrong. Try again!"
	}
}

struct APIError: ApplicationError {
	var title: String {
		return "API Error"
	}

	var debugDescription: String {
		return "Something went wrong."
	}
}

extension APIError: Unmarshaling {
	init(object: MarshaledObject) throws {

	}
}
