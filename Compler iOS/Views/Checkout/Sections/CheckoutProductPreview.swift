//
//  CheckoutProductPreview.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 13.12.2022.
//

import SwiftUI

/// Product preview with image and details
struct CheckoutProductPreview: View {
    
    let product: CheckoutProduct
    
    var productText: String {
        if product.configuration.gpuName != nil {
            return "Barva: \(product.color.name), CPU: \(product.configuration.cpuName), GPU: \(product.configuration.gpuName!), Paměť: \(product.configuration.memorySize.formattedAsStorage), Uložiště: \(product.configuration.storageSize.formattedAsStorage)"
        } else {
            return "Barva: \(product.color.name), CPU: \(product.configuration.cpuName), Paměť: \(product.configuration.memorySize.formattedAsStorage), Uložiště: \(product.configuration.storageSize.formattedAsStorage)"
        }
    }
    
    var body: some View {
        
        HStack(spacing: 15) {
            
            Spacer(minLength: 0)
            
            // Product image
            ProductImage(url: product.color.imagesUrl?[0] ?? product.product.mainImageUrl)
            
            // Product info
            VStack(alignment: .leading) {
                
                Text("\(product.product.brand) \(product.product.modelName)")
                    .bold()
                Text(product.configuration.price.formattedAsPrice)
                    .padding(.bottom, 5)
                Text(productText)
                    .font(.caption)
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
