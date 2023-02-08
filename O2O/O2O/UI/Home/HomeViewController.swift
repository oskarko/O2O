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
    func showError(_ errorMessage: String)
}

class HomeViewController: UIViewController  {
    
    // MARK: - Properties
    
    var viewModel: HomeViewModel!
    
    private let barTintColor = UIColor(red: 247/255, green: 132/255, blue: 15/255, alpha: 1.0)
    
    private let searchBar = UISearchBar()

    lazy var tableView: UITableView = {
        let tableView  = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = 80.0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeCell.nib, forCellReuseIdentifier: HomeCell.identifier)
        return tableView
    }()

    private let randomButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "questionmark"), for: .normal)
        button.backgroundColor = UIColor(red: 247/255, green: 132/255, blue: 15/255, alpha: 1.0)
        button.tintColor = .darkGray
        button.imageView?.setDimensions(height: 40,
                                        width: 40)
        button.addTarget(self, action: #selector(showRandomBeer), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    // MARK: - Selectors

    @objc func handleShowSearchBar() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }

    @objc func showRandomBeer() {
        viewModel.showRandomBeer()
    }

    // MARK: - Helpers
    
    private func configureUI() {

        configureNavigationBar(withTitle: "Find your beer", prefersLargeTitles: true, barTintColor: barTintColor)
        
        showSearchBarButton(shouldShow: true)
        
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.placeholder = "Enter a food name"
        definesPresentationContext = false
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .darkGray
            textField.backgroundColor = .lightText
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

        view.addSubview(randomButton)
        randomButton.setDimensions(height: 50, width: 50)
        randomButton.layer.cornerRadius = 25
        randomButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            right: view.safeAreaLayoutGuide.rightAnchor,
                            paddingBottom: 20,
                            paddingRight: 20)
    }
    
    private func showSearchBarButton(shouldShow: Bool) {
        navigationItem.rightBarButtonItem = shouldShow ? UIBarButtonItem(barButtonSystemItem: .search,
                                                                         target: self,
                                                                         action: #selector(handleShowSearchBar)) : nil
    }
    
    private func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
}

// MARK: - HomeViewControllerProtocol

extension HomeViewController: HomeViewControllerProtocol {

    func showError(_ errorMessage: String) {
        DispatchQueue.main.async {
            self.showErrorMessage(errorMessage)
        }
    }
    
    func reload(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell {
            if let imageURL = viewModel.beers[indexPath.row].imageURL {
                cell.itemImage.sd_setImage(with: URL(string: imageURL))
            } else {
                cell.itemImage.image = UIImage(named: "beer")
            }
            cell.itemNameLabel.text = viewModel.beers[indexPath.row].name
            cell.itemDescriptionLabel.text = viewModel.beers[indexPath.row].tagline
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath)
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        viewModel.prefetchRows(at: indexPaths)
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {}
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {}
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {}
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchByFood(searchText: searchText)
    }
    
}
