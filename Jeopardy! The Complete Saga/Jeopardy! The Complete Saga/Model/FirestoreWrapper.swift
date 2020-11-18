//
//  FirestoreWrapper.swift
//  Jeopardy! The Complete Saga
//
//  Created by Nilay Pachauri on 11/18/20.
//

import Firebase
import Foundation

class FirestoreWrapper {
    
    static let db = Firestore.firestore()
    static private let counterRef = FirestoreWrapper.db.collection("count").document("counters")
    
    static func getCluesForTriviaGauntlet(numOfClues: Int) -> [Clue] {
        return []
    }
    
    static private func getCounterData() -> Counter? {
        FirestoreWrapper.counterRef.getDocument { (document, error) in
            let result = Result {
                try document?.data()
            }
            switch result {
            case .success(let counter):
                if let counter = counter {
                    // A `Counter` value was successfully initialized from the DocumentSnapshot.
                    print("Counter: \(counter)")
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
        return nil
    }
    
    
}
