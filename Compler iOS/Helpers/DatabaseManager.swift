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
    
    func getProducts() async throws -> [Product] {
        
        let collection = db.collection("products")
        
        var products = [Product]()
        let snapshot = try await collection.getDocuments()
        for doc in snapshot.documents {
            products.append(try doc.data(as: Product.self))
        }
        
        return products
    }
    
    func getShippingMethods() async throws -> [ShippingMethod] {
            
        let collection = db.collection("shippingMethods")
            
        var shippingMethods = [ShippingMethod]()
        let snapshot = try await collection.getDocuments()
        for doc in snapshot.documents {
            shippingMethods.append(try doc.data(as: ShippingMethod.self))
        }
        
        return shippingMethods
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
        return try await doc.getDocument().data(as: Order.self)
    }

    // Get order number from cloud function
    func getOrderNumber() async throws -> Int {
        let function = Functions.functions()
        let result = try await function.httpsCallable("getOrderNumber").call().data as! [String: Any]
        return result["orderNumber"] as! Int
    }
    
    // MARK: User data
    func getOrders(userId: String) async throws -> [Order] {
        let collection = db.collection("orders")
        let query = collection.whereField("customerId", isEqualTo: userId)
        let data = try await query.getDocuments().documents.map({ doc in
            try doc.data(as: Order.self)
        })
        return data
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
    
    func setUserName(_ name: String) {
        let collection = db.collection("users")
        let doc = collection.document(UserManager.shared.user!.id)
        doc.setData(["name" : name], merge: true)
        UserManager.shared.user?.name = name
    }
    
    func setUserEmail(_ email: String) {
        let collection = db.collection("users")
        let doc = collection.document(UserManager.shared.user!.id)
        doc.setData(["email" : email], merge: true)
    }
}
