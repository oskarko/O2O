//  HomeViewController.swift
//  O2O
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit
import SDWebImage

protocol HomeViewControllerProtocol: AnyObject {
    func reload()
}

class HomeViewController: UIViewController  {
    
    // MARK: - Properties
    
    var viewModel: HomeViewModel!
    
    private let searchBar = UISearchBar()
    lazy var tableView: UITableView = {
        let tableView  = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80.0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.viewDidLoad()
        
    }
    
    // MARK: - Selectors
    @objc func handleShowSearchBar() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        
        configureNavigationBar(withTitle: "Search Bar", prefersLargeTitles: true, barTintColor: .systemPink)
        
        showSearchBarButton(shouldShow: true)
        
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.placeholder = "Search your beer"
        definesPresentationContext = false
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .darkGray
            textField.backgroundColor = .white
        }
        
        view.addSubview(tableView)
        var topPadding: CGFloat = 0.0
        if let topInset = UIApplication.shared.windows.first?.safeAreaInsets.top {
            topPadding = topInset
            
            NSLayoutConstraint.activate([
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: topPadding),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        
        
    }
    
    private func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                target: self,
                                                                action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    private func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
        
    }
    
}

// MARK: - HomeViewControllerProtocol

extension HomeViewController: HomeViewControllerProtocol {
    
    func reload(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.beers[indexPath.row].name
        content.secondaryText = viewModel.beers[indexPath.row].tagline
        cell.contentConfiguration = content
        return cell
    }
    
    
}
extension HomeViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("DEBUG: Search bar did begin editing...")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("DEBUG: Search bar did end editing...")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchByFood(searchText: searchText)
        print("DEBUG: Search text is: \(searchText)")
    }
    
}
