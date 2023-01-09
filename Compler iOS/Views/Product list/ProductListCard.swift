//
//  ProductListCard.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 01.12.2022.
//

import SwiftUI
import SDWebImageSwiftUI

/// Card representing product in product list
struct ProductListCard: View {
    
    let product: Product
    
    var body: some View {
        
        VStack(spacing: 5) {
            
            // Image
            ZStack(alignment: .topLeading) {
                ProductImage(url: product.mainImageUrl)
                Image(systemName: product.mainFocus.getIconName)
                    .foregroundColor(.accentColor)
                    .padding(8)
            }
            
            Spacer(minLength: 0)
            
            // Info
            VStack {
                Text("\(product.brand) \(product.modelName)")
                    .bold()
                    .multilineTextAlignment(.center)
                Text("Od \(product.lowestPriceFormatted)")
                    .font(.caption)
            }
            .padding()
            
            Spacer(minLength: 0)
        }
        .background(Color("SecondaryBG"))
        .cornerRadius(10)
    }
}

struct ProductListCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductListCard(product: .previewProduct)
            .preferredColorScheme(.dark)
            .frame(width: 200, height: 300)
    }
}
