//  DetailsViewController.swift
//  O2O
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit
import SDWebImage

protocol DetailsViewControllerProtocol: AnyObject {

}

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: DetailsViewModel!
    
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    

    // MARK: - Selectors

    
    // MARK: - Helpers

    private func configureUI() {
        guard let beer = viewModel.beer else { return }
        if let imageURL = beer.imageURL {
            imageDetail.sd_setImage(with: URL(string: imageURL))
        } else {
            imageDetail.image = UIImage(named: "beer")
        }
        nameLabel.text = beer.name
        descriptionLabel.text = beer.description
        taglineLabel.text = beer.tagline
    }
    
}

// MARK: - DetailsViewControllerProtocol

extension DetailsViewController: DetailsViewControllerProtocol {

}
