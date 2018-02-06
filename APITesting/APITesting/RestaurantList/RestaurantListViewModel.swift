//
//  RestaurantListViewModel.swift
//  APITesting
//
//  Created by Susmita Horrow on 06/02/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation
import ReactiveSwift

final class RestaurantListViewModel {
	let fetchRestaurantsAction = Action(execute: BaseAPIClient.shared.fetchSuggestedRestaurants)
	let restaurantViewModels: MutableProperty<[RestaurantViewModel]>  = MutableProperty([])
	let isExecuting = MutableProperty(false)

	init() {
		isExecuting <~ fetchRestaurantsAction.isExecuting
		restaurantViewModels <~ fetchRestaurantsAction.values.map { $0.list.map { RestaurantViewModel(restaurant: $0) } }
	}

	func fetchRestaurants() {
		fetchRestaurantsAction.apply().start()
	}
}
