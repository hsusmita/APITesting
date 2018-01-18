//
//  DataResponse+Parsing.swift
//  APITesting
//
//  Created by Susmita Horrow on 18/01/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation
import Alamofire
import Marshal

extension DataResponse {
	func parseError() -> ApplicationError {
		do {
			let json = try JSONParser.JSONObjectWithData(data!)
			do {
				print("Got Error from server = \(json.debugDescription))")
				let errorResponse = try APIError(object: json)
				return errorResponse
			} catch (let error) {
				print("Error while parsing error: \(error)")
				return ServerError(message: "Wrong Error Format")
			}
		} catch (let error) {
			print("Error while serializing error: \(error)")
			return ServerError(message: "Response Serialization Error")
		}
	}

	func parseData() -> ServiceResult<JSONObject> {
		do {
			let object = try JSONParser.JSONObjectWithData(self.data!)
			print("JSON to parse: \(String(describing: object))")
			return ServiceResult.success(object)

		} catch {
			if let parsingError = error as? MarshalError {
				print(parsingError.description)
			}
			return ServiceResult.failure(parseError())
		}
	}
}
