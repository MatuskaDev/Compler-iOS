//
//  DatabaseManager.swift
//  Compler
//
//  Created by Lukáš Matuška on 08.11.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class DatabaseManager {
    
    static let shared = DatabaseManager()
    private init() { }
    
    private let db = Firestore.firestore()
    
    func getNotebooks(completion: @escaping ([Notebook]?, Error?) -> Void) {
        
        let collection = db.collection("notebooks")
        
        Task.init {
            do {
                var notebooks = [Notebook]()
                let snapshot = try await collection.getDocuments()
                for doc in snapshot.documents {
                    notebooks.append(try doc.data(as: Notebook.self))
                }
                completion(notebooks, nil)
            }
            catch {
                completion(nil, error)
            }
        }
        
    }
}
