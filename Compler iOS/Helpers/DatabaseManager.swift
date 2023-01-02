//
//  DatabaseManager.swift
//  Compler
//
//  Created by Lukáš Matuška on 08.11.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseFunctions

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
    
    func getShippingMethods(completion: @escaping ([ShippingMethod]?, Error?) -> Void) {
            
            let collection = db.collection("shippingMethods")
            
            Task.init {
                do {
                    var shippingMethods = [ShippingMethod]()
                    let snapshot = try await collection.getDocuments()
                    for doc in snapshot.documents {
                        shippingMethods.append(try doc.data(as: ShippingMethod.self))
                    }
                    completion(shippingMethods, nil)
                }
                catch {
                    completion(nil, error)
                }
            }
    }

    func getShippingMethod(id: String, completion: @escaping (ShippingMethod?, Error?) -> Void) {
        
        let collection = db.collection("shippingMethods")
        let doc = collection.document(id)
        
        Task.init {
            do {
                let data = try await doc.getDocument().data(as: ShippingMethod.self)
                completion(data, nil)
            }
            catch {
                completion(nil, error)
            }
        }
    }

    func saveOrder(order: Order) throws {
        let collection = db.collection("orders")
        let doc = collection.document(order.id)
        try doc.setData(from: order)
    }

    // Get order with id async
    func getOrder(id: String) async throws -> Order {
        let collection = db.collection("orders")
        let doc = collection.document(id)
        let data = try await doc.getDocument().data(as: Order.self)
        return data
    }

    // Get order number from cloud function
    func getOrderNumber() async throws -> Int {
        let function = Functions.functions()
        let result = try await function.httpsCallable("getOrderNumber").call().data as! [String: Any]
        return result["orderNumber"] as! Int
    }
    
    func saveUser(_ user: User) throws {
        let collection = db.collection("users")
        let doc = collection.document(user.id)
        try doc.setData(from: user)
        
        DispatchQueue.main.async {
            UserManager.shared.user = user
        }
    }
    
    func getUser(id: String) async throws -> User {
        let collection = db.collection("users")
        let doc = collection.document(id)
        return try await doc.getDocument().data(as: User.self)
    }
}
