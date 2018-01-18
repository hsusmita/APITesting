//
//  BaseAPIClient.swift
//  APITesting
//
//  Created by Susmita Horrow on 18/01/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation
import Alamofire
import ReachabilitySwift
import Marshal

typealias RequestCompletionBlock<T> = (ServiceResult<T>) -> ()

class BaseAPIClient {
	private var sessionManager = SessionManager()
	let reachability = Reachability()!
	static let shared = BaseAPIClient()

	func signOut() {
		sessionManager.session.invalidateAndCancel()
		sessionManager = SessionManager()
	}

	@discardableResult func request<Value>(_ resource: Resource<Value>, completionBlock: @escaping RequestCompletionBlock<Value>) -> DataRequest {
		return request(urlRequest: resource.requestRouter.urlRequest()) { result in
			switch result {
			case .success(let dataResponse):
				do {
					let value = try resource.parse(dataResponse)
					completionBlock(ServiceResult.success(value))
				} catch {
					let parsingError = error as! MarshalError
					print(parsingError.description)

					let processedError = ParsingError(error: parsingError)
					completionBlock(ServiceResult.failure(processedError))
				}
			case .failure(let anyError):
				completionBlock(ServiceResult.failure(anyError))
			}
		}
	}

  @discardableResult private func request(urlRequest: URLRequestConvertible, completionBlock: @escaping (ServiceResult<JSONObject>) -> ()) -> DataRequest {
		return sessionManager.request(urlRequest)
			.debugLog()
			.validate(statusCode: 200...299)
			.responseData { [weak self] dataResponse in
				print(dataResponse.debugDescription)
				if dataResponse.error != nil {
					let isReachable = self?.reachability.isReachable ?? false
					let processedError = isReachable ? dataResponse.parseError() : InternetError()
					completionBlock(ServiceResult.failure(processedError))
				} else {
					let result = dataResponse.parseData()
					completionBlock(result)
				}
		}
	}
}

private extension Request {
	func debugLog() -> Self {
		#if DEBUG
			debugPrint(self)
		#endif
		return self
	}
}

