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
    
    func getProducts(completion: @escaping ([Product]?, Error?) -> Void) {
        
        let collection = db.collection("products")
        
        Task.init {
            do {
                var products = [Product]()
                let snapshot = try await collection.getDocuments()
                for doc in snapshot.documents {
                    products.append(try doc.data(as: Product.self))
                }
                completion(products, nil)
            }
            catch {
                completion(nil, error)
            }
        }
        
    }
}
