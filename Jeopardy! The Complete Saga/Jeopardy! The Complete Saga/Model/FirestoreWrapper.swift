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
    static private let jsonDecoder = JSONDecoder()
//    static private let semaphore = DispatchSemaphore(value: 1)
//    static private let queue = DispatchQueue(label: "test")
    static private let group = DispatchGroup()
    
    static func getCluesForTriviaGauntlet(numOfClues: Int) -> [Clue] {
        FirestoreWrapper.getCounterData() { (counter) in
            
        }
        return []
    }
    
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
