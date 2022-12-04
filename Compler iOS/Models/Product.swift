//
//  Computer.swift
//  Compler
//
//  Created by Lukáš Matuška on 08.11.2022.
//

import Foundation

struct Product: Codable, Identifiable {
    
    var id: String
    var brand: String
    var modelName: String
    var screenSize: Int
    var mainFocus: ProductFocus
    var productType: ProductType
    
    var shortDescription: String
    var description: String
    var mainImageUrl: URL?
    var colors: [ProductColor]
    
    var features: [ProductFeature]?
    
    var configurations: [ProductConfiguration]
}

extension Product {
    var lowestPrice: Int {
        configurations.map { conf in
            conf.price
        }.sorted().first ?? 0
    }
}

extension Product {
    static let previewProduct = Product(id: UUID().uuidString,
                                        brand: "Apple",
                                        modelName: "MacBook Pro",
                                        screenSize: 14,
                                        mainFocus: .creative,
                                        productType: .notebook,
                                        shortDescription: "Nejvýkonnější notebook",
                                        description: "Dlouhý popis",
                                        colors: [.previewColor],
                                        configurations: [.previewConfiguration])
}
