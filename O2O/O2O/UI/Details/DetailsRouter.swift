//  DetailsRouter.swift
//  O2O
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class DetailsRouter {
    
    // MARK: - Properties
    
    weak var viewController: DetailsViewController?

    // MARK: - Helpers
    
    static func getViewController(item: BeerModel) -> DetailsViewController {
        let configuration = configureModule(item: item)

        return configuration.vc
    }
    
    private static func configureModule(item: BeerModel) -> (vc: DetailsViewController, vm: DetailsViewModel, rt: DetailsRouter) {
        let viewController = DetailsViewController()
        let router = DetailsRouter()
        let viewModel = DetailsViewModel(item: item)

        viewController.viewModel = viewModel

        viewModel.router = router
        viewModel.view = viewController

        router.viewController = viewController

        return (viewController, viewModel, router)
    }
    
    // MARK: - Routes
    
}
