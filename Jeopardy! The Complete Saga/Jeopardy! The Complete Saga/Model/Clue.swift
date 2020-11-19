//
//  Clue.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/18/20.
//

import Foundation

// MARK: - Enumerations

enum QuestionType: Int {
    case JEOPARDY        = 0
    case DOUBLE_JEOPARDY = 1
    case FINAL_JEOPARDY  = 2
    
    var description: String {
        switch self {
        case .JEOPARDY:
            return "Jeopardy"
        case .DOUBLE_JEOPARDY:
            return "Double Jeopardy"
        case .FINAL_JEOPARDY:
            return "Final Jeopardy"
        default:
            return ""
        }
    }
}

class Clue {
    
    // MARK: - Private Class Attributes
    
    var answer: String
    var airDate: Date?
    var category: String
    var categoryID: Int
    var dollarValue: Int?
    var episode: Int
    var order: Int
    var question: String
    var season: String
    var type: QuestionType?
    
    // MARK: - Init Functions
    
    init(answer: String, airDate: Date, category: String, categoryID: Int, dollarValue: Int, episode: Int, order:Int, question: String, season: String, type: QuestionType) {
        self.answer = answer
        self.airDate = airDate
        self.category = category
        self.categoryID = categoryID
        self.dollarValue = dollarValue
        self.episode = episode
        self.order = order
        self.question = question
        self.season = season
        self.type = type
    }
    
    init(answer: String, airDate: String, category: String, categoryID: Int, dollarValue: String, episode: Int, order: Int, question: String, season: String, type: QuestionType) {
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
        self.order = order
        self.question = question
        self.season = season
        self.type = type
    }
    
    // MARK: - Getters
    
    func getAnswer() -> String {
        return self.answer
    }
    
    func getAirDate() -> Date? {
        return self.airDate
    }
    
    func getCategory() -> String {
        return self.category
    }
    
    func getCategoryID() -> Int {
        return self.categoryID
    }
    
    func getDollarValue() -> Int? {
        return self.dollarValue
    }
    
    func getEpisode() -> Int {
        return self.episode
    }
    
    func getQuestion() -> String {
        return self.question
    }
    
    func getSeason() -> String {
        return self.season
    }
    
    func getType() -> QuestionType? {
        return self.type
    }
}
