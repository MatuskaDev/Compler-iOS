//
//  CheckoutProduct.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 09.12.2022.
//

import Foundation

struct CheckoutProduct {
    let product: Product
    let configuration: ProductConfiguration
    let color: ProductColor
}

extension CheckoutProduct {
    static let previewCheckoutProduct = CheckoutProduct(product: Product.previewProduct, configuration: ProductConfiguration.previewConfiguration, color: ProductColor.previewColor)
}
