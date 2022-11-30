//
//  ProductColor.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 30.11.2022.
//

import Foundation

struct ProductColor: Identifiable, Codable {
    var id: String
    var name: String
    var hexColorCode: String
    var imagesUrl: [URL]?
}

extension ProductColor {
    static let previewColor = ProductColor(id: UUID().uuidString, name: "Space gray", hexColorCode: "#696761")
}
