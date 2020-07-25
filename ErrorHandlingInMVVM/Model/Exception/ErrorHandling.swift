//
//  ErrorHandling.swift
//  ErrorHandlingInMVVM
//
//  Created by 金融研發一部-張書彬 on 2020/7/26.
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
