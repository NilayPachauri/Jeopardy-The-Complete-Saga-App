//
//  TriviaGauntletGame.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/19/20.
//

import Foundation

class TriviaGauntletGame: NSObject {
    
    // MARK: - Private Data Members
    private var clueList: [Clue]
    private var currentIndex: Int?
    private var score: Int
        
    // Swift Singleton Pattern
    static let shared = TriviaGauntletGame()
    
    // MARK: - Initializers
    override init() {
        self.clueList = []
        self.currentIndex = nil
        self.score = 0
        
        super.init()
    }
    
    // MARK: - Class Methods
    func setClueList(_ clueList: [Clue]) -> Void {
        self.clueList = clueList
        self.currentIndex = (clueList.count > 0) ? 0 : nil
    }
    
    func nextClue() -> Void {
        self.currentIndex = (self.currentIndex != nil) ? self.currentIndex! + 1 : nil
    }
    
    func getCurrentClue() -> Clue? {
        return (self.currentIndex != nil) ? self.clueList[self.currentIndex!] : nil
    }
    
    func incrementScore() -> Void {
        self.score += 1
    }
    
    func getScore() -> Int {
        return self.score
    }
    
    func finishedGame() -> Void {
        self.clueList = []
        self.currentIndex = nil
        self.score = 0
    }
    
    
    
}
