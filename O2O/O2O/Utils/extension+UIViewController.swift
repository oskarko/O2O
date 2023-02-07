//
//  extension+UIViewController.swift
//  O2O
//
//  Created by Guadalupe Morales carmona on 7/2/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func configureNavigationBar(withTitle title: String,
                                prefersLargeTitles: Bool,
                                barTintColor: UIColor = .systemPink) {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = barTintColor
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    }
}
