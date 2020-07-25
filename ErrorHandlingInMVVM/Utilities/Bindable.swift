//
//  Bindable.swift
//  ErrorHandlingInMVVM
//
//  Created by 金融研發一部-張書彬 on 2020/7/25.
//  Copyright © 2020 Joshua Chang. All rights reserved.
//

import Foundation

class Bindable<T> {
    
    typealias Listener = ((T) -> ())
    
    private var willSetListener: Listener?
    private var didSetListener: Listener?
    
    var value: T {
        willSet{
            willSetListener?(value)
        }
        didSet {
            didSetListener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }
    
    func bindWillSetObservers(_ listener: Listener?) {
        self.willSetListener = listener
    }

    func bindDidSetObservers(_ listener: Listener?) {
        self.didSetListener = listener
    }
    
}
