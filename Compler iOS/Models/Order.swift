//
//  Order.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 13.12.2022.
//

import Foundation

struct Order: Identifiable, Codable {
    
    var id: String = UUID().uuidString
    var number: Int? = nil
    var createdAt: Date = Date()
    var orderStatus: OrderStatus = .processing
    var paymentStatus: PaymentStatus = .unpaid
    var paymentId: String? = nil
    var trackingNumber: String? = nil
    var trackingURL: URL? = nil
    
    // Order details
    let product: OrderProduct
    let shippingMethodId: String
    
    // Customer details
    let shippingInfo: Address
    let billingInfo: Address
    
    let customerId: String?
    let contactPhone: String
    let contactEmail: String
    
    let totalAmount: Int
}

extension Order {
    static let previewOrder = Order(
        createdAt: Date.now,
        product: OrderProduct(productId: "1", configurationId: "1", colorId: "1"),
        shippingMethodId: "1",
        shippingInfo: Address(firstName: "Lukáš", lastName: "Matuška", street: "Křižíkova 201", city: "Brno", zip: "60200"),
        billingInfo: Address(firstName: "Lukáš", lastName: "Matuška", street: "Křižíkova 201", city: "Brno", zip: "60200"),
        customerId: "1",
        contactPhone: "+420 777 777 777",
        contactEmail: "test@gmail.com",
        totalAmount: 1000
    )
}

enum OrderStatus: Codable {
    case processing
    case shipped
    case delivered
    case canceled
}

struct OrderProduct: Codable {
    let productId: String
    let configurationId: String
    let colorId: String
}

struct ShippingMethod: Identifiable, Equatable, Codable {
    let id: String
    let title: String
    let description: String
    let price: Int
}

enum PaymentStatus: Codable {
    case unpaid
    case paid
}

struct Address: Codable {
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
