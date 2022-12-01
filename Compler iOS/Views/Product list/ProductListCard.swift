//
//  ProductListCard.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 01.12.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductListCard: View {
    
    let product: Product
    
    var body: some View {
        VStack(spacing: 5) {
            Spacer(minLength: 0)
            if product.mainImageUrl == nil {
                Image(systemName: "laptopcomputer")
                    .resizable()
                    .scaledToFit()
                    .padding(20)
                    .cornerRadius(10)
            } else {
                WebImage(url: product.mainImageUrl)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
            }
            
            Text("\(product.brand) \(product.modelName)")
                .bold()
                .multilineTextAlignment(.center)
            Text("Od \(formatPrice(product.lowestPrice))")
                .font(.caption)
            Spacer(minLength: 0)
        }
        .padding()
        .background {
            Color("SecondaryBG")
        }
        .cornerRadius(10)
    }
    
    func formatPrice(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "czk"
        formatter.currencyGroupingSeparator = " "
        formatter.currencyDecimalSeparator = ","
        formatter.minimumFractionDigits = 0
        return formatter.string(from: price as NSNumber)!
    }
}

struct ProductListCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductListCard(product: .previewProduct)
            .preferredColorScheme(.dark)
    }
}
