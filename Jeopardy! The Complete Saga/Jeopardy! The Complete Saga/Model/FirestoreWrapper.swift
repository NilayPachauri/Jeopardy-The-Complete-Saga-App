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
                // Collect a List of length numOfClues where each index corresponds to a randomly selected QuestionType of that clue
                let clueTypes: [QuestionType] = FirestoreWrapper.getClueTypes(triviaGauntletSettings, counter)
                
                // Calculate the Probabilities List to randomly select a clue from a category
                var probabilities: [Double] = [convertBoolToDouble(triviaGauntletSettings.useDifficulty1Questions), convertBoolToDouble(triviaGauntletSettings.useDifficulty2Questions), convertBoolToDouble(triviaGauntletSettings.useDifficulty3Questions), convertBoolToDouble(triviaGauntletSettings.useDifficulty4Questions), convertBoolToDouble(triviaGauntletSettings.useDifficulty5Questions)]
                let probabilitiesSum = probabilities.reduce(0, +)
                probabilities = probabilities.map( { $0 / probabilitiesSum } )
                
                for clueType in clueTypes {
                    FirestoreWrapper.getClueFromCategory(counter, questionType: clueType, orderProbabilities: probabilities, listAppendCompletion)
                }
                performSegueCompletion()
            } else {
                print("Counter is nil")
            }
        }
        return []
    }
    
    // MARK: - Trivia Gauntlet Helper Functions
    static private func getClueTypes(_ triviaGauntletSettings: TriviaGauntletSettings, _ counter: Counter) -> [QuestionType] {
        
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
    
    static private func getClueFromCategory(_ counter: Counter, questionType: QuestionType, orderProbabilities: [Double], _ completion: @escaping (_ data: [Clue]) -> Void = { _ in }) -> Void {
        // Determine the Collection Reference being used and Max Count of that collection
        var collectionRef: CollectionReference? = nil
        var collectionCount: Int? = nil
        
        switch questionType {
        case .JEOPARDY:
            collectionRef = FirestoreWrapper.jeopardyRef
            collectionCount = counter.getJeopardyCategoriesCount()
        case .DOUBLE_JEOPARDY:
            collectionRef = FirestoreWrapper.doubleJeopardyRef
            collectionCount = counter.getDoubleJeopardyCategoriesCount()
        case .FINAL_JEOPARDY:
            collectionRef = FirestoreWrapper.finalJeopardyRef
            collectionCount = counter.getFinalJeopardyCategoriesCount()
        }
        
        if let collectionRef = collectionRef, let collectionCount = collectionCount {
            
            // Get Random Integer from 0 to (not including) collectionCount as the query index
            let categoryID = Int.random(in: 0..<collectionCount)
            
            // Determine whether we check greater than or equals (true) or less than or equals (false)
            let useGreaterThanOrEquals = Bool.random()
            
            // Query to Find Document
            var query: Query
            if useGreaterThanOrEquals {
                query = collectionRef.whereField("categoryID", isGreaterThanOrEqualTo: categoryID).order(by: "categoryID", descending: false).limit(to: 1)
            } else {
                query = collectionRef.whereField("categoryID", isLessThanOrEqualTo: categoryID).order(by: "categoryID", descending: true).limit(to: 1)
            }
            
            // Get Documents from Query
            query.getDocuments { (query, error) in
                
                let result = Result {
                    query?.documents
                }
                switch result {
                case .success(let documents):
                    if let documents = documents {
                        for document in documents {
                            let category = try? FirebaseDecoder().decode(Category.self, from: document.data())
                            // TODO: Randomly pick a clue from the category and create clue object
                            completion(clue)
                        }
                    } else {
                        // A nil value was successfully initialized from the QuerySnapshot,
                        // or the QuerySnapshot was nil.
                        print("Query does not exist")
                    }
                case .failure(let error):
                    // Fetching the Documents from the Query resulted in an error
                    print("Error Fetching Documents: \(error)")
                }
            }
        }
        
        
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
                print("Error decoding object: \(error)")
            }
        }
    }
}
