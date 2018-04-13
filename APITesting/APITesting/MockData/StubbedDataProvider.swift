//
//  StubbedDataProvider.swift
//  APITesting
//
//  Created by Susmita Horrow on 04/04/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation

protocol StubbedDataProvider: RequestRouterProtocol {
    static var allStubbedDataProviders: [StubbedDataProvider] { get }
    var successData: Any { get }
}

extension StubbedDataProvider {
    static var successStubbedData: [String: Any] {
        let successData: [String: Any] = allStubbedDataProviders.reduce([:]) { (result, stubProvider) in
            var finalResult = result
            finalResult[stubProvider.label] = stubProvider.successData
            return finalResult
        }
        return successData
    }
    
    static var errorStubbedData: [String: ApplicationError] {
        let errorData: [String: ApplicationError] = allStubbedDataProviders.reduce([:]) { (result, stubProvider) in
            var finalResult = result
            finalResult[stubProvider.label] = InternetError()
            return finalResult
        }
        return errorData
    }
}
