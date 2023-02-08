//  DetailsViewModel.swift
//  O2O
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class DetailsViewModel {
    
    // MARK: - Properties
    
    weak var view: DetailsViewControllerProtocol?
    var router: DetailsRouter?

    var beer: BeerModel?
    
    // MARK: - Helpers

    init(item: BeerModel) {
            self.beer = item
        }
    
    
}
