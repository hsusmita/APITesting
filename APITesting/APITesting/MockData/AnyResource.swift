//
//  AnyResource.swift
//  APITesting
//
//  Created by Susmita Horrow on 04/04/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation

struct AnyResource {
    var inner: Resource<Any>
    var type: String
    
    init<T>(resource: Resource<T>) {
        inner = Resource<Any>(requestRouter: resource.requestRouter) { (jsonObject)  in
            return try resource.parse(jsonObject)
        }
        type = "\(T.self)"
    }
}
