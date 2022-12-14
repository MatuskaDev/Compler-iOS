//
//  Order.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 13.12.2022.
//

import Foundation

struct Order: Identifiable {
    
    var id: String = UUID().uuidString
    var createdAt: Date = Date()
    var orderStatus: OrderStatus = .processing
    var paymentStatus: PaymentStatus = .unpaid
    
    // Order details
    let product: OrderProduct
    let shippingMethodId: String
    
    // Customer details
    let shippingInfo: Address
    let billingInfo: Address
    
    let customerId: String?
    let contactPhone: String
    let contactEmail: String
}

enum OrderStatus {
    case processing
    case shipped
    case delivered
    case canceled
}

struct OrderProduct {
    let productId: String
    let configurationId: String
    let colorId: String
}

struct ShippingMethod: Identifiable, Equatable {
    let id: String
    let title: String
    let description: String
    let price: Int
}

enum PaymentStatus {
    case unpaid
    case paid
}

struct Address {
    let firstName: String
    let lastName: String
    let street: String
    let city: String
    let zip: String
    
    // Bussiness info
    var companyName: String? = nil
    var cin: String? = nil
    var vat: String? = nil
}
