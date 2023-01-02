//
//  User.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 29.12.2022.
//

import Foundation

struct User: Codable {
    var id: String
    var email: String?
    var name: String?
    
    var savedPhoneNumber: String?
    var savedShippingInfo: Address?
    var savedAddBillingInfoPreference: Bool?
    var savedBillingInfo: Address?
}
