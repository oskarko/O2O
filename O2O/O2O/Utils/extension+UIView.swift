//
//  extension+UIView.swift
//  O2O
//
//  Created by Oscar Rodriguez Garrucho on 7/2/23.
//

import UIKit

extension UIView {

    static var identifier: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    func anchor(top: NSLayoutYAxisAnchor? = nil,
                    left: NSLayoutXAxisAnchor? = nil,
                    bottom: NSLayoutYAxisAnchor? = nil,
                    right: NSLayoutXAxisAnchor? = nil,
                    paddingTop: CGFloat = 0,
                    paddingLeft: CGFloat = 0,
                    paddingBottom: CGFloat = 0,
                    paddingRight: CGFloat = 0,
                    width: CGFloat? = nil,
                    height: CGFloat? = nil) {

            translatesAutoresizingMaskIntoConstraints = false

            if let top = top {
                topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
            }

            if let left = left {
                leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
            }

            if let bottom = bottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }

            if let right = right {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }

            if let width = width {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }

            if let height = height {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }

        func centerX(inView view: UIView) {
            translatesAutoresizingMaskIntoConstraints = false
            centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }

        func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                     paddingLeft: CGFloat = 0, constant: CGFloat = 0) {

            translatesAutoresizingMaskIntoConstraints = false
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true

            if let left = leftAnchor {
                anchor(left: left, paddingLeft: paddingLeft)
            }
        }

        func setDimensions(height: CGFloat, width: CGFloat) {
            translatesAutoresizingMaskIntoConstraints = false
            heightAnchor.constraint(equalToConstant: height).isActive = true
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        func setHeight(height: CGFloat) {
            translatesAutoresizingMaskIntoConstraints = false
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }

        func setWidth(width: CGFloat) {
            translatesAutoresizingMaskIntoConstraints = false
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
}
