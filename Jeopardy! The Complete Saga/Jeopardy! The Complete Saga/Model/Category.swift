//
//  Category.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/19/20.
//

import Foundation

class Category: Codable {
    
    // MARK: - Private Class Attributes
    private(set) var airDate: String?
    private(set) var category: String?
    private(set) var categoryID: Int?
    private(set) var clues: [String : [String : String]]?
    private(set) var episode: Int?
    private(set) var season: String?
    
    // MARK: - Coding Key
    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case category
        case categoryID
        case clues
        case episode
        case season
    }
}
