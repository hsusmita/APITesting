//
//  APITestingServerTests.swift
//  APITestingServerTests
//
//  Created by Susmita Horrow on 04/04/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import XCTest
@testable import APITesting
@testable import ReactiveSwift
@testable import Result

class APITestingServerTests: XCTestCase {
    var signalProducer: SignalProducer<SuggestedRestaurants, AnyApplicationError>!
    private let baseAPIClient = BaseAPIClient.shared
    
    override func setUp() {
        super.setUp()
    }
    
    func testFetchRestaurants() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch restaurants")
        
        // When
        let resource = Resource<SuggestedRestaurants>(requestRouter: RequestRouter.fetchList)
        self.signalProducer = baseAPIClient.request(resource)
        var currentResult: Result<SuggestedRestaurants, AnyApplicationError>?                
        self.signalProducer.startWithResult { (result) in
            currentResult = result
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30.0)
        
        // Assert
        XCTAssertNil(currentResult?.error?.debugDescription)
        XCTAssertNotNil(currentResult?.value)
    }
}
