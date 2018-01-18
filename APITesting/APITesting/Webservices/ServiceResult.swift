//
//  ServiceResult.swift
//  APITesting
//
//  Created by Susmita Horrow on 18/01/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation

enum ServiceResult<Value> {
	case success(Value)
	case failure(ApplicationError)
}
