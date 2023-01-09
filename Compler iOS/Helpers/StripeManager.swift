//
//  StripeManager.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 10.12.2022.
//

import Foundation
import FirebaseFunctions
import Stripe

class StripeManager {
    static let shared = StripeManager()
    var functions = Functions.functions()
    
    private init() {
        //functions.useEmulator(withHost: "http://localhost", port: 5001)
    }
    
    // Get stripe publishable key
    func getPublishableKey() async {
        do {
            let data = try await functions.httpsCallable("getStripePublishableKey").call().data as! [String: Any]
            let key = data["stripepublishablekeys"] as! String
            StripeAPI.defaultPublishableKey = key
            print("Publishable key: \(key)")
        } catch {
            print("Error getting publishable key: \(error.localizedDescription)")
        }
    }

    // Get stripe payment intent client secret and id
    func getPaymentIntent(orderId: String, amount: Int) async throws -> (id: String, secret: String) {
        let convertedAmount = amount * 100
        let data = try await functions.httpsCallable("getStripePaymentIntent").call(["amount" : convertedAmount, "orderId" : orderId]).data as! [String: Any]
        
        let secret = data["clientSecret"] as! String
        let id = data["paymentIntentId"] as! String
        
        print("Payment intent id: \(id)")
        
        return (id: id, secret: secret)
    }
}
