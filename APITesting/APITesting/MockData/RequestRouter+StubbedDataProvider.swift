//
//  RequestRouter+StubbedDataProvider.swift
//  APITesting
//
//  Created by Susmita Horrow on 04/04/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation

extension RequestRouter: StubbedDataProvider {
    static var allStubbedDataProviders: [StubbedDataProvider] {
        return [RequestRouter.fetchList, RequestRouter.fetchDetail(id: "1")]
    }
    
    var successData: Any {
        switch self {
        case .fetchList:
            return SuggestedRestaurants.dummyObject
        case .fetchDetail:
            return SuggestedRestaurants.dummyObject.list.first!
        }
    }
}
