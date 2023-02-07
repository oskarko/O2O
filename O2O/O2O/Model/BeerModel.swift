//
//  BeerModel.swift
//  O2O
//
//  Created by Guadalupe Morales carmona on 7/2/23.
//

import Foundation

import Foundation

// MARK: - BeerModelElement
struct BeerModel: Codable {
    let id: Int
    let name: String
    let tagline: String
    let firstBrewed: String
    let description: String
    let imageURL: String
    let abv: Double
    let ibu: Double?
    let targetFg: Int
    let targetOg: Double
    let ebc: Int?
    let srm: Double?
    let ph: Double?
    let attenuationLevel: Double
    let volume: BoilVolume
    let boilVolume: BoilVolume
    let method: Method
    let ingredients: Ingredients
    let foodPairing: [String]
    let brewersTips: String
    let contributedBy: ContributedBy
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case tagline
        case firstBrewed = "first_brewed"
        case description
        case imageURL = "image_url"
        case abv
        case ibu
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case ebc
        case srm
        case ph
        case attenuationLevel = "attenuation_level"
        case volume
        case boilVolume = "boil_volume"
        case method
        case ingredients
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
    
    // MARK: - BoilVolume
    struct BoilVolume: Codable {
        let value: Double
        let unit: Unit
    }
    
    enum Unit: String, Codable {
        case celsius = "celsius"
        case grams = "grams"
        case kilograms = "kilograms"
        case litres = "litres"
    }
    
    enum ContributedBy: String, Codable {
        case aliSkinnerAliSkinner = "Ali Skinner <AliSkinner>"
        case samMasonSamjbmason = "Sam Mason <samjbmason>"
    }
    
    // MARK: - Ingredients
    struct Ingredients: Codable {
        let malt: [Malt]
        let hops: [Hop]
        let yeast: String
    }
    
    // MARK: - Hop
    struct Hop: Codable {
        let name: String
        let amount: BoilVolume
        let add: Add
        let attribute: Attribute
    }
    
    enum Add: String, Codable {
        case dryHop = "dry hop"
        case end = "end"
        case middle = "middle"
        case start = "start"
    }
    
    enum Attribute: String, Codable {
        case aroma = "aroma"
        case attributeFlavour = "Flavour"
        case bitter = "bitter"
        case flavour = "flavour"
    }
    
    // MARK: - Malt
    struct Malt: Codable {
        let name: String
        let amount: BoilVolume
    }
    
    // MARK: - Method
    struct Method: Codable {
        let mashTemp: [MashTemp]
        let fermentation: Fermentation
        let twist: String?
        
        enum CodingKeys: String, CodingKey {
            case mashTemp = "mash_temp"
            case fermentation, twist
        }
    }
    
    // MARK: - Fermentation
    struct Fermentation: Codable {
        let temp: BoilVolume
    }
    
    // MARK: - MashTemp
    struct MashTemp: Codable {
        let temp: BoilVolume
        let duration: Int?
    }
}
