//
//  FirestoreWrapper.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/18/20.
//

import CodableFirebase
import Firebase
import FirebaseFirestore
import Foundation

class FirestoreWrapper {
    
    static let db = Firestore.firestore()
    static private let counterRef = FirestoreWrapper.db.collection("count").document("counters")
    
    
    // MARK: - Public Static Methods
    static func getCluesForTriviaGauntlet(triviaGauntletSettings: TriviaGauntletSettings, _ listAppendCompletion: @escaping (_ data: [Clue]) -> Void = {_ in }, _ performSegueCompletion: @escaping () -> Void = { }  ) -> [Clue] {
        FirestoreWrapper.getCounterData() { (counter) in
            if let counter = counter {
                let questionDistribution: [QuestionType: Int] = FirestoreWrapper.getQuestionsDistribution(triviaGauntletSettings, counter)
                FirestoreWrapper.getNumOfCluesByQuestionType(triviaGauntletSettings, numOfClues: questionDistribution[.JEOPARDY] ?? 0, questionType: .JEOPARDY, listAppendCompletion)
                FirestoreWrapper.getNumOfCluesByQuestionType(triviaGauntletSettings, numOfClues: questionDistribution[.DOUBLE_JEOPARDY] ?? 0, questionType: .DOUBLE_JEOPARDY, listAppendCompletion)
                FirestoreWrapper.getNumOfCluesByQuestionType(triviaGauntletSettings, numOfClues: questionDistribution[.FINAL_JEOPARDY] ?? 0, questionType: .FINAL_JEOPARDY, listAppendCompletion)
                performSegueCompletion()
            } else {
                print("Counter is nil")
            }
        }
        return []
    }
    
    // MARK: - Trivia Gauntlet Helper Functions
    static private func getQuestionsDistribution(_ triviaGauntletSettings: TriviaGauntletSettings, _ counter: Counter) -> [QuestionType: Int] {
        
        // Create List of which category each clue will come from
        var categoriesOfClues: [QuestionType] = []
        
        // Create Probabilities List
        var probabilities: [Double] = []
        
        // Get Sum of All Participating Categories and Append to probabilities
        var sum: Int = 0
        
        if triviaGauntletSettings.useJeopardyQuestions {
            sum += counter.getJeopardyCategoriesCount()
            probabilities.append(Double(counter.getJeopardyCategoriesCount()))
        } else {
            probabilities.append(0.0)
        }
        
        if triviaGauntletSettings.useDoubleJeopardyQuestions {
            sum += counter.getDoubleJeopardyCategoriesCount()
            probabilities.append(Double(counter.getDoubleJeopardyCategoriesCount()))
        } else {
            probabilities.append(0.0)
        }
        
        if triviaGauntletSettings.useFinalJeopardyQuestions {
            sum += counter.getFinalJeopardyCategoriesCount()
            probabilities.append(Double(counter.getFinalJeopardyCategoriesCount()))
        } else {
            probabilities.append(0.0)
        }
        
        // Change probabilties to be percentage rather than raw number
        probabilities = probabilities.map { $0 / Double(sum) }
        
        // Populate List of Categories by Clue
        for _ in 1...triviaGauntletSettings.numOfClues {
            if let questionType: QuestionType = QuestionType(rawValue: randomNumber(probabilities: probabilities)) {
                categoriesOfClues.append(questionType)
            }
        }
        
        // Create a Dictionary for Counting Frequencies in categoriesOfClues
        let counts = Dictionary(categoriesOfClues.map { ($0, 1) }, uniquingKeysWith: +)
        
        // Return Value
        return counts
    }
    
    static private func getNumOfCluesByQuestionType(_ triviaGauntletSettings: TriviaGauntletSettings, numOfClues: Int, questionType: QuestionType, _ completion: @escaping (_ data: [Clue]) -> Void = { _ in }) -> Void {
        
    }
    
    
    // MARK: - Private Static Helper Functions
    static private func getCounterData(_ completion: @escaping (_ data: Counter?) -> Void = {_ in } ) -> Void {
        FirestoreWrapper.getDocumentAsClass(docRef: FirestoreWrapper.counterRef, Counter.self) { (counter) in
            completion(counter)
        }
    }
    
    static func getDocumentAsClass<T: Codable>(docRef: DocumentReference, _ type: T.Type, _ completion: @escaping (_ data: T?) -> Void = { _ in }) -> Void {
        
        // Get the Document and store it into object
        FirestoreWrapper.counterRef.getDocument { (document, error) in
            let result = Result {
                document?.data()
            }
            switch result {
            case .success(let data):
                if let data = data {
                    // A `T` value was successfully initialized from the DocumentSnapshot.
                    let object = try? FirebaseDecoder().decode(type, from: data)
                    completion(object)
                } else {
                    // A nil value was successfully initialized from the DocumentSnapshot,
                    // or the DocumentSnapshot was nil.
                    print("Document does not exist")
                }
            case .failure(let error):
                // A `T` value could not be initialized from the DocumentSnapshot.
                print("Error decoding counter: \(error)")
            }
        }
    }
}
