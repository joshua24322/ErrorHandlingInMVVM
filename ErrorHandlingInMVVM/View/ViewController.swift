//
//  ViewController.swift
//  ErrorHandlingInMVVM
//
//  Created by 金融研發一部-張書彬 on 2020/7/25.
//  Copyright © 2020 Joshua Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Property
    
    var mockLabel: UILabel! // assume the label promise has value
    
    var parameter: MockParameter?
    
    var viewModel: MockViewModel = MockViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }

    // MARK: - Private Method
    
    private func setupBinding() {
        viewModel.viewElement.bindDidSetObservers { (successfulText) in
            self?.mockLabel.text = successfulText
        }
        
        viewModel.errorMessage.bindDidSetObservers { (errMessage) in
            self?.mockLabel.text = errMessage
        }
    }

}

