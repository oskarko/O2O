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
    var newBeers = [BeerModel]()
    var onlyIPABeers = [BeerModel]()
    var searchText: String?
    var page = 1
    var onlyIPA: Bool = false
    
    // MARK: - Lifecycle
    
    init(_ service: ServiceProtocol = Service()) {
        self.service = service
    }
    
    // MARK: - Helpers

    func numberOfRows() -> Int {
        return onlyIPA ? onlyIPABeers.count : beers.count
    }

    func fetchData() {
        let path = (self.searchText ?? "") + "&page=\(page)"
        service.fetch(.data, textSearch: path) { [weak self ] (result: ResultResponse<[BeerModel]>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                if !data.isEmpty {
                    if self.page == 1 {
                        self.beers = data
                        self.view?.reload()
                    } else {
                        DispatchQueue.main.async {
                            self.newBeers = []
                            self.newBeers = data
                            self.addMoreItems(self.newBeers)
                        }
                    }
                }

            case .failure(let error):
                self.view?.showError(error.message ?? "")
                self.beers = []
                self.view?.reload()
            }
        }
    }
    
    func searchByFood(searchText: String?){
        
        if searchText != "", let searchText = searchText {
            self.searchText = searchText.replacingOccurrences(of: " ", with: "_")
            fetchData()
        } else {
            DispatchQueue.main.async {
                self.beers.removeAll()
                self.view?.reload()
            }
        }
    }

    func didSelectRowAt(_ indexPath: IndexPath) {
        let item = beers[indexPath.row]
        self.router?.toDetails(item: item)
    }

    func showRandomBeer() {
        service.fetch(.random, textSearch: "" ) { [weak self ] (result: ResultResponse<[BeerModel]>) in
            guard let self = self else { return }

            switch result {
            case .success(let data):
                print(data)
                if let beer = data.first {
                    self.router?.toDetails(item: beer)
                }

            case .failure(let error):
                self.view?.showError(error.message ?? "")
            }
        }
    }

    func prefetchRows(at indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLastCell) {
            loadMoreItems()
        }
    }

    private func isLastCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row == beers.count - 1 && newBeers.count % 25 == 0
    }

    func loadMoreItems() {
            page += 1
            fetchData()
    }

    func addMoreItems(_ items: [BeerModel]) {
        if !items.isEmpty {
            let previousSize = self.beers.count
            self.beers.append(contentsOf: items)
            let newSize = self.beers.count
            var newIndices: [IndexPath] = []
            for idx in previousSize..<newSize{
                newIndices.append( IndexPath(item: idx, section: 0) )
            }

            DispatchQueue.main.async {
                self.view?.reload()
            }

        }
    }

    func isOnlyIPA() {
        if onlyIPA {
            DispatchQueue.main.async {
                for beer in self.beers {
                    if beer.tagline.contains("IPA") || beer.name.contains("IPA") {
                        self.onlyIPABeers.append(beer)
                    }
                }
                self.view?.reload()
            }
        }
    }
}
