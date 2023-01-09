//
//  NavigationHelper.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 08.01.2023.
//

import Foundation

class NavigationHelper: ObservableObject {
    @Published var path: [Navigation] = []
}

enum Navigation: Hashable {
    case account
    case list
    case recommender
    case productDetail(Product)
    case checkout(CheckoutProduct)
}
