//
//  CheckoutProductPreview.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 13.12.2022.
//

import SwiftUI

struct CheckoutProductPreview: View {
    
    let product: CheckoutProduct
    
    var productText: String {
        if product.configuration.gpuName != nil {
            return "Barva: \(product.color.name), CPU: \(product.configuration.cpuName), GPU: \(product.configuration.gpuName!), Paměť: \(product.configuration.formattedMemorySize), Uložiště: \(product.configuration.formattedStorageSize)"
        } else {
            return "Barva: \(product.color.name), CPU: \(product.configuration.cpuName), Paměť: \(product.configuration.formattedMemorySize), Uložiště: \(product.configuration.formattedStorageSize)"
        }
    }
    
    var body: some View {
        
        HStack(spacing: 15) {
            
            Spacer(minLength: 0)
            
            // Product image
            ProductImage(url: product.color.imagesUrl?[0] ?? product.product.mainImageUrl)
            
            // Product info
            VStack(alignment: .leading, spacing: 5) {
                
                VStack(alignment: .leading) {
                    Spacer(minLength: 0)
                    Text("\(product.product.brand) \(product.product.modelName)")
                        .bold()
                    Text(product.configuration.formattedPrice)
                    
                    Spacer(minLength: 0)
                    
                    Text(productText)
                        .font(.caption)
                }
                
                
            }
            
            Spacer(minLength: 0)
        }
        .frame(height: 100)
    }
}

struct CheckoutProductPreview_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutProductPreview(product: .previewCheckoutProduct)
            .preferredColorScheme(.dark)
    }
}