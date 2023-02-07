//
//  ServiceType.swift
//  O2O
//
//  Created by Guadalupe Morales carmona on 7/2/23.
//

import Foundation

enum ServiceType {
     case data
    
    var urlString: String {
        switch self {
        case .data: return "https://api.punkapi.com/v2/beers"
        }
    }
}
