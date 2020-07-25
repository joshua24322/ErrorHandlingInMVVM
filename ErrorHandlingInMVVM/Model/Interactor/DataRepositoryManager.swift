//
//  DataRepositoryManager.swift
//  ErrorHandlingInMVVM
//
//  Created by 金融研發一部-張書彬 on 2020/7/25.
//  Copyright © 2020 Joshua Chang. All rights reserved.
//

import Foundation

enum MockServicesError: Error {
    /// MockService response object with error
    case mockServiceResponseError(message: String)
    /// Server response object is nil
    case withoutResponseObject
    /// Fatel Error with message
    case fatelErrorWith(message: String)
    /// Fatel Error
    case fatelError
}

protocol DataRepositoryProtocol {
    func queryMockServices(_ parameter: MockParameter?, completion: @escaping((Result<String?, MockServicesError>) -> ()))
}

final class DataRepositoryManager: DataRepositoryProtocol {
    
    func queryMockServices(_ parameter: MockParameter?, completion: @escaping((Result<String?, MockServicesError>) -> ())) {
        guard
            let dataNo1 = parameter?.dataNO1,
            let dataNo2 = parameter?.dataNO2,
            let dataNo3 = parameter?.dataNO3,
            let request = Factory.fetchesMockRequest(dataNo1, dataNo2, dataNo3)
            else { return }
        
        MockWebAPI.send(request) { (response, error) in
            if let err = error {
                completion(.failure(MockServicesError.fatelErrorWith(message: err.localizedDescription)))
            } else {
                guard let response = response as? MockResponse else { return completion(.failure(MockServicesError.fatelError)) }
                if let statusCode = response.statusCode, statusCode == "0" {
                    guard let dataString = response.dataString else { return completion(.failure(MockServicesError.withoutResponseObject)) }
                    completion(.success(dataString))
                } else {
                    guard let message = response.message else { return completion(.failure(MockServicesError.withoutResponseObject)) }
                    completion(.failure(MockServicesError.mockServiceResponseError(message: message)))
                }
            }
        }
        
    }
    
}
