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
import ReactiveSwift
import Result

typealias RequestCompletionBlock<T> = (ServiceResult<T>) -> ()

class BaseAPIClient {
	private var sessionManager = SessionManager()
	let reachability = Reachability()!
	static let shared = BaseAPIClient()
	private let (cancelAllRequests, cancelAllRequestsObserver) = Signal<(), NoError>.pipe()

	func signOut() {
		sessionManager.session.invalidateAndCancel()
		sessionManager = SessionManager()
	}

	@discardableResult func request<Value: Codable>(_ resource: Resource<Value>, completionBlock: @escaping RequestCompletionBlock<Value>) -> DataRequest {
		let urlRequest = resource.requestRouter.urlRequest()
		return request(urlRequest: urlRequest, completionBlock: completionBlock)
	}

	@discardableResult private func request<Value: Codable>(urlRequest: URLRequestConvertible, completionBlock: @escaping RequestCompletionBlock<Value>) -> DataRequest {
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
					let result: ServiceResult<Value> = dataResponse.parseData()
					completionBlock(result)
				}
		}
	}

	func request<Value: Codable>(_ resource: Resource<Value>) -> SignalProducer<Value, AnyError> {
		return SignalProducer<Value, AnyError> { sink, disposable in
			let request = self.request(resource, completionBlock: { result in
				switch result {
				case .success(let dataResponse):
					sink.send(value: dataResponse)
				case .failure(let error):
					sink.send(error: AnyError(error))
				}
 			})
			disposable.observeEnded {
				[weak request] in
				request?.cancel()
			}
		}.observe(on: UIScheduler())
			.take(until: cancelAllRequests)
			.on(failed: { error in
				print("On Error Log: \(error), request: \(resource.requestRouter.path)")
		})
	}

	//MARK: SuggestedRestaurants
	func fetchSuggestedRestaurants() -> SignalProducer<SuggestedRestaurants, AnyError> {
		let resource = Resource<SuggestedRestaurants>(requestRouter: RequestRouter.fetchList)
		return request(resource)
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

