//
//  APITestingReactiveTests.swift
//  APITestingTests
//
//  Created by Susmita Horrow on 06/02/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import XCTest
@testable import APITesting
@testable import ReactiveSwift

class APITestingReactiveTests: XCTestCase {
	var signalProducer: SignalProducer<SuggestedRestaurants, AnyError>!
	private let baseAPIClient = BaseAPIClient.shared

    override func setUp() {
        super.setUp()
    }

	func testFetchRestaurantsReactive() {
		let expectation = XCTestExpectation(description: "Fetch restaurants")
		self.signalProducer = baseAPIClient.fetchSuggestedRestaurants()
		self.signalProducer.start { (event) in
			switch event {
			case .value:
				XCTAssert(true, "List of restaurants fetched")

			case .failed(let error):
				XCTAssert(false, error.debugDescription)

			case .completed, .interrupted:
				break
			}
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 30.0)
	}
}
