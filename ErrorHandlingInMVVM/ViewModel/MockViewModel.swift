//
//  MockViewModel.swift
//  ErrorHandlingInMVVM
//
//  Created by 金融研發一部-張書彬 on 2020/7/25.
//  Copyright © 2020 Joshua Chang. All rights reserved.
//

import Foundation

fileprivate enum HookErrorHandling {
    case withoutResponse
    case mockServiceResponseError(errMessage: String)
    case fatelErrorWith(errMessage: String)
    case fatelError
}

extension HookErrorHandling {
    var message: String {
        switch self {
        case .withoutResponse:
            return "Server without response object"
        case .mockServiceResponseError(let errMessage):
            return "Mock service response error with: \(errMessage)"
        case .fatelErrorWith(let errMessage):
            return "Fatel error with: \(errMessage)"
        case .fatelError:
            return "Encountered fatel Error"
        }
    }
}

final class MockViewModel {
    
    let viewElement: Bindable<String?> = Bindable(nil)
    
    let errorMessage: Bindable<String?> = Bindable(nil)
    
    private var dataSource: DataRepositoryProtocol
    
    init(dataSource: DataRepositoryProtocol = DataRepositoryManager()) {
        self.dataSource = dataSource
    }
    
    func invokeMockService(_ parameter: MockParameter?, completionHandler handler: ((Result<String?, MockServicesError>) -> ())? = nil) {
        dataSource.queryMockServices(parameter) { (result) in
            switch result {
            case .success(let dataString):
                if let dataValue = dataString {
                    self.viewElement.value = dataValue
                }
            case .failure(let error):
                self.feedingError(error)
            }
        }
    }
    
    // MARK: - Error Handling
    private func feedingError(_ error: MockServicesError) {
        switch error {
        case .withoutResponseObject:
            self.errorMessage.value = HookErrorHandling.withoutResponse.message
        case .mockServiceResponseError(let message):
            self.errorMessage.value = HookErrorHandling.mockServiceResponseError(errMessage: message).message
        case .fatelErrorWith(let message):
            self.errorMessage.value = HookErrorHandling.fatelErrorWith(errMessage: message).message
        case .fatelError:
            self.errorMessage.value = HookErrorHandling.fatelError.message
        }
    }
    
}
