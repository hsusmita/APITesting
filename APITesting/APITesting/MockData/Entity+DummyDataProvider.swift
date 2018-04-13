//
//  Entity+DummyDataProvider.swift
//  APITesting
//
//  Created by Susmita Horrow on 04/04/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation

extension Restaurant: DummyDataProvider {
    static var dummyObject: Restaurant {
        return dummyCollection.first!
    }
    
    static var dummyCollection: [Restaurant] {
        let data = Bundle.main.loadData(fileName: "Restaurant", type: "txt")!
        let root = try! JSONDecoder().decode(Root<SuggestedRestaurants>.self, from: data)
        return root.value.list
    }
}

extension SuggestedRestaurants: DummyDataProvider {
    static var dummyObject: SuggestedRestaurants {
        return SuggestedRestaurants(list: Restaurant.dummyCollection)
    }
    
    static var dummyCollection: [SuggestedRestaurants] {
        return [dummyObject]
    }
}
