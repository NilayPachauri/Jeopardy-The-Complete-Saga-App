//
//  TriviaGauntletSettings.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/19/20.
//

import Foundation

class TriviaGauntletSettings {
    
    // MARK: - Private Class Attributes
    private(set) var numOfClues: Int
    private(set) var useJeopardyQuestions: Bool
    private(set) var useDoubleJeopardyQuestions: Bool
    private(set) var useFinalJeopardyQuestions: Bool
    private(set) var useDifficulty1Questions: Bool
    private(set) var useDifficulty2Questions: Bool
    private(set) var useDifficulty3Questions: Bool
    private(set) var useDifficulty4Questions: Bool
    private(set) var useDifficulty5Questions: Bool
    
    // MARK: - Initializers
    init(numOfClues: Int, useJeopardyQuestions: Bool, useDoubleJeopardyQuestions: Bool, useFinalJeopardyQuestions: Bool, useDifficulty1Questions: Bool, useDifficulty2Questions: Bool, useDifficulty3Questions: Bool, useDifficulty4Questions: Bool, useDifficulty5Questions: Bool) {
        self.numOfClues = numOfClues
        self.useJeopardyQuestions = useJeopardyQuestions
        self.useDoubleJeopardyQuestions = useDoubleJeopardyQuestions
        self.useFinalJeopardyQuestions = useFinalJeopardyQuestions
        self.useDifficulty1Questions = useDifficulty1Questions
        self.useDifficulty2Questions = useDifficulty2Questions
        self.useDifficulty3Questions = useDifficulty3Questions
        self.useDifficulty4Questions = useDifficulty4Questions
        self.useDifficulty5Questions = useDifficulty5Questions
    }
}
