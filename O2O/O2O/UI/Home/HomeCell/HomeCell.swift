//
//  HomeCell.swift
//  O2O
//
//  Created by Oscar Rodriguez Garrucho on 7/2/23.
//

import UIKit

class HomeCell: UITableViewCell {


    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
