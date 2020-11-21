//
//  TraditionalSettings.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/20/20.
//

import Foundation

class TraditionalSettings {
    
    // MARK: - Private Class Attributes
    private(set) var numOfCategories: Int
    private(set) var hasJeopardyRound: Bool
    private(set) var hasDoubleJeopardyRound: Bool
    private(set) var hasFinalJeopardyRound: Bool
    private(set) var numOfMinutesPerRound: Int
    
    // MARK: - Initializers
    init(numOfCategories: Int, hasJeopardyRound: Bool, hasDoubleJeopardyRound: Bool, hasFinalJeopardyRound: Bool, numOfMinutesPerRound: Int) {
        self.numOfCategories = numOfCategories
        self.hasJeopardyRound = hasJeopardyRound
        self.hasDoubleJeopardyRound = hasDoubleJeopardyRound
        self.hasFinalJeopardyRound = hasFinalJeopardyRound
        self.numOfMinutesPerRound = numOfMinutesPerRound
    }
}
