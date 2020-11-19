//
//  Counter.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/18/20.
//

import Foundation

class Counter: Codable {
    
    // MARK: - Private Class Attributes
    private var jeopardyCategoriesCount: Int
    private var doubleJeopardyCategoriesCount: Int
    private var finalJeopardyCategoriesCount: Int
    
    // MARK: - Initializers
    init(jeopardyCategoriesCount: Int, doubleJeopardyCategoriesCount: Int, finalJeopardyCategoriesCount: Int) {
        self.jeopardyCategoriesCount = jeopardyCategoriesCount
        self.doubleJeopardyCategoriesCount = doubleJeopardyCategoriesCount
        self.finalJeopardyCategoriesCount = finalJeopardyCategoriesCount
    }
    
    // MARK: - Getters
    func getJeopardyCategoriesCount() -> Int {
        return self.jeopardyCategoriesCount
    }
    
    func getDoubleJeopardyCategoriesCount() -> Int {
        return self.doubleJeopardyCategoriesCount
    }
    
    func getFinalJeopardyCategoriesCount() -> Int {
        return self.finalJeopardyCategoriesCount
    }
    
    // MARK: - Coding Key
    enum CodingKeys: String, CodingKey {
        case jeopardyCategoriesCount = "jcount"
        case doubleJeopardyCategoriesCount = "djcount"
        case finalJeopardyCategoriesCount = "fjcount"
    }
}
