//
//  extension+UIView.swift
//  O2O
//
//  Created by Oscar Rodriguez Garrucho on 7/2/23.
//

import UIKit

public extension UIView {
    /// Get the file name of the View.
    static var identifier: String {
        return String(describing: self)
    }

    /// Get the Nib instance from the file name.
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
