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
                                        mainImageUrl: URL(string: "https://firebasestorage.googleapis.com/v0/b/compler-a99af.appspot.com/o/products%2FCA04B8BC-4B36-429D-B8F4-CCE7C4033557%2F5DC1CC93-404B-4867-84CE-07989CC9B919%2F07EED76D-D749-4070-8A52-C3594C9E032C.jpg?alt=media&token=067b1cc3-78bd-42ce-b5a7-7197e5466f8e")!,
                                        colors: [.previewColor],
                                        configurations: [.previewConfiguration])
}
