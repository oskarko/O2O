//
//  BeerModel.swift
//  O2O
//
//  Created by Oscar Rodriguez Garrucho on 7/2/23.
//

import Foundation

import Foundation

// MARK: - BeerModelElement
struct BeerModel: Codable {
    let id: Int?
    let name: String?
    let tagline: String?
    let firstBrewed: String?
    let description: String?
    let imageURL: String?
    let foodPairing: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case tagline
        case firstBrewed = "first_brewed"
        case description
        case imageURL = "image_url"
        case foodPairing = "food_pairing"
    }
}
