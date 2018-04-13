//
//  RestaurantListViewModelTests.swift
//  RestaurantListViewModelTests
//
//  Created by Susmita Horrow on 18/01/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import XCTest
@testable import APITesting

class RestaurantListViewModelTests: XCTestCase {
	private let baseAPIClient = MockBaseAPIClient()
    var sut: RestaurantListViewModel!
        
	override func setUp() {
        super.setUp()
        sut = RestaurantListViewModel(baseAPIClient: baseAPIClient)
        baseAPIClient.spy.reset()
    }

    func testFetchRestaurants_makes_server_call() {
        //When
        sut.fetchRestaurants()
        
        //Assert
        let recordedResource = baseAPIClient.spy.elements.first
        XCTAssertEqual(recordedResource?.inner.requestRouter.path, "\(RequestRouter.fetchList.path)")
        XCTAssertEqual(recordedResource?.type, "\(SuggestedRestaurants.self)")
    }
    
    func testFetchRestaurants_error_updates_error() {
        //Given
        baseAPIClient.stub.responseType = .error
        
        //When
        sut.fetchRestaurants()

        //Assert
        XCTAssertTrue(sut.isError.value)
    }
    
    func testFetchRestaurants_success_updates_viewModel() {
        //Given
        baseAPIClient.stub.responseType = .success
        let key = RequestRouter.fetchList
        let data: SuggestedRestaurants = baseAPIClient.stub.successData[key.label] as! SuggestedRestaurants
        
        //When
        sut.fetchRestaurants()
        
        //Assert
        XCTAssertFalse(sut.isError.value)
        XCTAssertEqual(sut.restaurantViewModels.value.count, data.list.count)
    }
}
