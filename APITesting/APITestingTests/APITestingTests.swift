//
//  APITestingTests.swift
//  APITestingTests
//
//  Created by Susmita Horrow on 18/01/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import XCTest
@testable import APITesting

class APITestingTests: XCTestCase {
	private let baseAPIClient = BaseAPIClient.shared

    override func setUp() {
        super.setUp()
    }

	func testFetchRestaurants() {
		let expectation = XCTestExpectation(description: "Fetch restaurants")
		let resource = Resource<SuggestedRestaurants>(requestRouter: RequestRouter.fetchList)
		baseAPIClient.request(resource) { (result) in
			switch result {
			case .success:
				XCTAssert(true, "List of restaurants fetched")
			case .failure(let error):
				XCTAssert(false, error.debugDescription)
			}
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 30.0)
	}
}
