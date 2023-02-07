//  DetailsViewController.swift
//  O2O
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol DetailsViewControllerProtocol: AnyObject {

}

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: DetailsViewModel!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    

    // MARK: - Selectors

    
    // MARK: - Helpers

    private func configureUI() {
        view.backgroundColor = .systemPurple

    }
    
}

// MARK: - DetailsViewControllerProtocol

extension DetailsViewController: DetailsViewControllerProtocol {

}