//
//  RestaurantListViewModel.swift
//  APITesting
//
//  Created by Susmita Horrow on 06/02/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

final class RestaurantListViewModel {
    private let fetchRestaurantsAction: Action<Void, SuggestedRestaurants, AnyApplicationError>
	let restaurantViewModels: MutableProperty<[RestaurantViewModel]> = MutableProperty([])
	let isExecuting = MutableProperty(false)
    let isError = MutableProperty(false)
    
    init(baseAPIClient: BaseAPIClient) {
        let resource = Resource<SuggestedRestaurants>(requestRouter: RequestRouter.fetchList)
        fetchRestaurantsAction = Action(execute: { return baseAPIClient.request(resource) })
		isExecuting <~ fetchRestaurantsAction.isExecuting
        restaurantViewModels <~ fetchRestaurantsAction.values.map { $0.list.map { RestaurantViewModel(restaurant: $0) } }
        isError <~ fetchRestaurantsAction.errors.map { _ in return true }
	}

	func fetchRestaurants() {
//        fetchRestaurantsAction.apply().start()
	}
}
