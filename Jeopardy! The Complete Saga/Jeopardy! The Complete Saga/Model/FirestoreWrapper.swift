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
    
    // MARK: - Public Static Class Attributes
    static let db = Firestore.firestore()
    
    // MARK: - Private Static Class Attributes
    static private let counterRef = FirestoreWrapper.db.collection("count").document("counters")
    static private let jeopardyRef = FirestoreWrapper.db.collection("jeopardy")
    static private let doubleJeopardyRef = FirestoreWrapper.db.collection("double_jeopardy")
    static private let finalJeopardyRef = FirestoreWrapper.db.collection("final_jeopardy")
    
    
    // MARK: - Public Static Methods
    static func getCluesForTriviaGauntlet(triviaGauntletSettings: TriviaGauntletSettings, _ listAppendCompletion: @escaping (_ data: [Clue]) -> Void = {_ in }, _ performSegueCompletion: @escaping () -> Void = { }  ) -> [Clue] {
        FirestoreWrapper.getCounterData() { (counter) in
            if let counter = counter {
                let categoriesOfClues: [QuestionType] = FirestoreWrapper.getCategoriesOfClues(triviaGauntletSettings, counter)
                for categoryOfClue in categoriesOfClues {
                    FirestoreWrapper.getClueFromCategory(triviaGauntletSettings, questionType: categoryOfClue, listAppendCompletion)
                }
                performSegueCompletion()
            } else {
                print("Counter is nil")
            }
        }
        return []
    }
    
    // MARK: - Trivia Gauntlet Helper Functions
    static private func getCategoriesOfClues(_ triviaGauntletSettings: TriviaGauntletSettings, _ counter: Counter) -> [QuestionType] {
        
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
        
        // Return Value
        return categoriesOfClues
    }
    
    static private func getClueFromCategory(_ triviaGauntletSettings: TriviaGauntletSettings, questionType: QuestionType, _ completion: @escaping (_ data: [Clue]) -> Void = { _ in }) -> Void {
        
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
