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
    static func getCluesForTriviaGauntlet(numOfClues: Int) -> [Clue] {
        FirestoreWrapper.getCounterData() { (counter) in
            
        }
        return []
    }
    
    // MARK: - Trivia Gauntlet Helper Functions
    static private func getQuestionsDistribution(numOfClues: Int, counter: Counter, useJeopardy: Bool = true, useDoubleJeopardy: Bool = true, useFinalJeopardy: Bool = true) -> [Int] {
        
        // Create List of which category each clue will come from
        var categoriesOfClues: [Int] = []
        
        // Create Probabilities List
        var probabilities: [Double] = []
        
        // Get Sum of All Participating Categories and Append to probabilities
        var sum: Int = 0
        
        if useJeopardy {
            sum += counter.getJeopardyCategoriesCount()
            probabilities.append(Double(counter.getJeopardyCategoriesCount()))
        } else {
            probabilities.append(0.0)
        }
        
        if useDoubleJeopardy {
            sum += counter.getDoubleJeopardyCategoriesCount()
            probabilities.append(Double(counter.getDoubleJeopardyCategoriesCount()))
        } else {
            probabilities.append(0.0)
        }
        
        if useFinalJeopardy {
            sum += counter.getFinalJeopardyCategoriesCount()
            probabilities.append(Double(counter.getFinalJeopardyCategoriesCount()))
        } else {
            probabilities.append(0.0)
        }
        
        // Change probabilties to be percentage rather than raw number
        probabilities = probabilities.map { $0 / Double(sum) }
        
        // Populate List of Categories by Clue
        for _ in 1...numOfClues {
            categoriesOfClues.append(randomNumber(probabilities: probabilities))
        }
        
        // Return Value
        return categoriesOfClues
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
