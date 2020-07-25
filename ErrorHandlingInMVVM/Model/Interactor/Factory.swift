//
//  Factory.swift
//  ErrorHandlingInMVVM
//
//  Created by 金融研發一部-張書彬 on 2020/7/25.
//  Copyright © 2020 Joshua Chang. All rights reserved.
//

import Foundation

final class Factory {
    
    static func fetchesMockRequest(_ dataNO1: String, _ dataNO2: String, _ dataNO3: String) -> MockRequest? {
        
        guard let request = MockRequest() else { return MockRequest() }
        request.dataNO1 = dataNO1
        request.dataNO2 = dataNO2
        request.dataNO3 = dataNO3
        
        return request
    }
    
}
