//  HomeViewModel.swift
//  O2O
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    // MARK: - Properties
    
    weak var view: HomeViewControllerProtocol?
    var router: HomeRouter?
    
    private var service: ServiceProtocol
    
    var beers = [BeerModel]()
    var searchText: String?
    
    // MARK: - Lifecycle
    
    init(_ service: ServiceProtocol = Service()) {
        self.service = service
    }
    
    // MARK: - Helpers
    
    func viewDidLoad() {
     //   fetchData()
    }
    
    
    func fetchData() {
        service.fetch(.data, textSearch: self.searchText ?? "" ) { [weak self ] (result: ResultResponse<[BeerModel]>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                print(data)
                self.beers = data
                self.view?.reload()
            case .failure(let error):
                print(error.message ?? "")
            }
        }
    }
    
    func searchByFood(searchText: String?){
        
        if let searchText = searchText {
            self.searchText = searchText.replacingOccurrences(of: " ", with: "_")
            fetchData()
        } else {
            self.beers.removeAll()
            view?.reload()
        }
    }
}
