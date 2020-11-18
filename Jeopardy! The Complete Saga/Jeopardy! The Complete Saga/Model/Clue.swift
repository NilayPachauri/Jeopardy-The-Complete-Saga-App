//
//  Clue.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/18/20.
//

import Foundation

class Clue {
    
    // MARK: - Private Class Attributes
    
    var answer: String
    var airDate: Date?
    var category: String
    var categoryID: Int
    var dollarValue: Int?
    var episode: Int
    var question: String
    var season: String
    var type: QuestionType?
    
    // MARK: - Init Functions
    
    init(answer: String, airDate: Date, category: String, categoryID: Int, dollarValue: Int, episode: Int, question: String, season: String, type: QuestionType) {
        self.answer = answer
        self.airDate = airDate
        self.category = category
        self.categoryID = categoryID
        self.dollarValue = dollarValue
        self.episode = episode
        self.question = question
        self.season = season
        self.type = type
    }
    
    init(answer: String, airDate: String, category: String, categoryID: Int, dollarValue: String, episode: Int, question: String, season: String, type: String) {
        self.answer = answer
        
        // Extract Date From String
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy/mm/dd"
        self.airDate = dateFormatter.date(from: airDate)
        
        self.category = category
        self.categoryID = categoryID
        
        // Extract Amount from String
        let amount = dollarValue.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        self.dollarValue = Int(amount)
        
        self.episode = episode
        self.question = question
        self.season = season
        
        // Extract Type from String
        switch type {
        case "Jeopardy":
            self.type = .JEOPARDY
        case "Double Jeopardy":
            self.type = .DOUBLE_JEOPARDY
        case "Final Jeopardy":
            self.type = .FINAL_JEOPARDY
        default:
            self.type = nil
        }
    }
}
