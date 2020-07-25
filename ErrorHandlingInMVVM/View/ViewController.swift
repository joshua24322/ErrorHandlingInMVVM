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
    
    @IBOutlet weak var mockLabel: UILabel!
    
    var parameter: MockParameter?
    
    var viewModel: MockViewModel = MockViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        triggerMockService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBinding()
    }

    // MARK: - Private Method
    
    private func setupBinding() {
        viewModel.viewElement.bindDidSetObservers { [weak self] (successfulText) in
            self?.mockLabel.text = successfulText
        }
        
        viewModel.errorMessage.bindDidSetObservers { [weak self] (errMessage) in
            self?.mockLabel.text = errMessage
        }
    }
    
    private func triggerMockService() {
        self.viewModel.invokeMockService(self.parameter)
    }

}

