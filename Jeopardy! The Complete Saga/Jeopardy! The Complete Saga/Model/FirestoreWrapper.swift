//
//  FirestoreWrapper.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/18/20.
//

import Firebase
import FirebaseFirestore
import Foundation

class FirestoreWrapper {
    
    static let db = Firestore.firestore()
    static private let counterRef = FirestoreWrapper.db.collection("count").document("counters")
    static private let jsonDecoder = JSONDecoder()
    
    static func getCluesForTriviaGauntlet(numOfClues: Int) -> [Clue] {
        let counter = FirestoreWrapper.getCounterData()
        print("Jeopardy Count: \(counter?.getJeopardyCategoriesCount())")
        print("Double Jeopardy Count: \(counter?.getDoubleJeopardyCategoriesCount())")
        print("Final Jeopardy Count: \(counter?.getFinalJeopardyCategoriesCount())")
        return []
    }
    
    static private func getCounterData() -> Counter? {
        let counter = FirestoreWrapper.getDocumentAsClass(docRef: FirestoreWrapper.counterRef, Counter.self) {
            _ in
        }
        
        print("Jeopardy Count: \(counter?.getJeopardyCategoriesCount())")
        print("Double Jeopardy Count: \(counter?.getDoubleJeopardyCategoriesCount())")
        print("Final Jeopardy Count: \(counter?.getFinalJeopardyCategoriesCount())")
        return counter
    }
    
    static func getDocumentAsClass<T: Codable>(docRef: DocumentReference, _ type: T.Type, _ completion: @escaping (_ data: T?) -> Void) -> T? {
        
        // Create object of Class T
        var object: T? = nil
        
        // Get the Document and store it into object
        FirestoreWrapper.counterRef.getDocument { (document, error) in
            let result = Result {
                document?.data()
            }
            switch result {
            case .success(let objectData):
                if let objectData = objectData {
                    // Serialize the Dictionary into a JSON Data representation, then decode it using the Decoder()
                    if let data = try? JSONSerialization.data(withJSONObject: objectData, options: []) {
                        // A `Counter` value was successfully initialized from the DocumentSnapshot.
                        object = try? FirestoreWrapper.jsonDecoder.decode(type, from: data)
                        completion(object)
                    }
                } else {
                    // A nil value was successfully initialized from the DocumentSnapshot,
                    // or the DocumentSnapshot was nil.
                    print("Document does not exist")
                }
            case .failure(let error):
                // A `Counter` value could not be initialized from the DocumentSnapshot.
                print("Error decoding counter: \(error)")
            }
        }
        
        // Return object
        return object
    }
    
    
}
