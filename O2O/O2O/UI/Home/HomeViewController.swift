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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeCell.nib, forCellReuseIdentifier: HomeCell.identifier)
        return tableView
    }()

    private let randomButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "dice"), for: .normal)
        button.backgroundColor = UIColor(red: 247/255, green: 132/255, blue: 15/255, alpha: 1.0)
        button.tintColor = .darkGray
        button.imageView?.setDimensions(height: 30,
                                        width: 30)
        return button
    }()
    
    private let onlyIPALabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Only IPA: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let onlyIPASwitch: UISwitch = {
        let switchControl  = UISwitch()
        switchControl.isOn = true
        switchControl.isEnabled = true
        switchControl.onTintColor =  UIColor(red: 247/255, green: 132/255, blue: 15/255, alpha: 1.0)
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.setOn(false, animated: false)
        return switchControl
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
    
    @objc func switchStateDidChange(_ sender:UISwitch!) {
           viewModel.onlyIPA = sender.isOn
           tableView.reloadData()
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

        view.addSubview(onlyIPALabel)
        onlyIPALabel.setDimensions(height: 50, width: 150)
        onlyIPALabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor,
                              paddingTop: 20, paddingLeft: 20)
        
        view.addSubview(onlyIPASwitch)
        onlyIPASwitch.setDimensions(height: 50, width: 80)
        onlyIPASwitch.anchor(top: onlyIPALabel.topAnchor,
                                  left: onlyIPALabel.rightAnchor, right: view.safeAreaLayoutGuide.rightAnchor,
                                  paddingTop: 10, paddingLeft: 40, paddingRight: 20)
        onlyIPASwitch.addTarget(self, action: #selector(switchStateDidChange), for: .valueChanged)

        view.addSubview(tableView)
        tableView.anchor(top: onlyIPALabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor
                             )

        view.addSubview(randomButton)
        randomButton.setDimensions(height: 50, width: 50)
        randomButton.layer.cornerRadius = 25
        randomButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            right: view.safeAreaLayoutGuide.rightAnchor,
                            paddingBottom: 20,
                            paddingRight: 20)
        randomButton.addTarget(self, action: #selector(showRandomBeer), for: .touchUpInside)


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
    
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var foods = "Food pairings: \n"
        let beer = viewModel.cellForRow(indexPath)
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell {
            if let imageURL = beer.imageURL {
                cell.itemImage.sd_setImage(with: URL(string: imageURL))
            } else {
                cell.itemImage.image = UIImage(named: "beer")
            }
            cell.itemNameLabel.text = beer.name
            
            for food in beer.foodPairing ?? [] {
                foods = foods + "\n" + food
            }
            cell.itemDescriptionLabel.text = foods
            
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

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
        searchBar.text = ""
        viewModel.searchByFood(searchText: "")
        onlyIPASwitch.isOn = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {}
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {}
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchByFood(searchText: searchText)
    }
    
}
