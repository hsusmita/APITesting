//
//  MockBaseAPIClient.swift
//  APITesting
//
//  Created by Susmita Horrow on 04/04/18.
//  Copyright © 2018 hsusmita. All rights reserved.
//

import Foundation
import ReactiveSwift

class MockBaseAPIClient: BaseAPIClient {
    var stub: Stub
    private(set) var spy = Tracker<AnyResource>()
    
    init(stub: Stub) {
        self.stub = stub
    }
    
    convenience override init() {
        var successData: [String: Any] = [:]
        var errorData: [String: ApplicationError] = [:]
        
        RequestRouter.successStubbedData.forEach {
            successData[$0.key] = $0.value
        }
        
        RequestRouter.errorStubbedData.forEach {
            errorData[$0.key] = $0.value
        }
        self.init(stub: Stub(successData: successData, errorData: errorData))
    }
    
    override func request<Value>(_ resource: Resource<Value>) -> 
        SignalProducer<Value, AnyApplicationError> where Value : Decodable, Value : Encodable {
            spy.track(AnyResource(resource: resource))
            
            return SignalProducer<Value, AnyApplicationError> { [weak self] sink, disposable in
                guard let this = self else {
                    return
                }
                let key = resource.requestRouter.label
                let result: ServiceResult<Value> = this.stub.stubbedData[key]!.resultMapper()
                
                switch result {
                case .success(let dataResponse):
                    sink.send(value: dataResponse)
                    sink.sendCompleted()
                case .failure(let error):
                    sink.send(error: AnyApplicationError(error))
                    sink.sendCompleted()
                }
        }
    }
}
