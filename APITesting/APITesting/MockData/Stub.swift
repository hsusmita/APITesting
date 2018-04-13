//
//  Stub.swift
//  APITesting
//
//  Created by Susmita Horrow on 04/04/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation

class Stub {
    enum StubbedResponseType {
        case success
        case error
    }
    private(set) var stubbedData: [String: ServiceResult<Any>] = [:]
    let successData: [String: Any]
    let errorData: [String: ApplicationError]
    
    var responseType = StubbedResponseType.success {
        didSet {
            setupResponses()
        }
    }
    
    private func setupResponses() {
        stubbedData.removeAll()
        switch responseType {
        case .success:
            successData.forEach { (arg) in
                let (key, value) = arg
                stubbedData[key] = ServiceResult.success(value)
            }
        case .error:
            errorData.forEach {(arg) in
                let (key, value) = arg
                stubbedData[key] = ServiceResult.failure(value)
            }
        }
    }
    
    init(successData: [String: Any], errorData: [String: ApplicationError]) {
        self.successData = successData
        self.errorData = errorData
        setupResponses()
    }
}
