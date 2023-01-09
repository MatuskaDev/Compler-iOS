//
//  ProductFeature.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 01.12.2022.
//

import SwiftUI

struct ProductFeatureCell: View {
    
    let feature: ProductFeature
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: feature.icon)
            Text(feature.title)
                .lineLimit(1)
                .fixedSize()
        }
        .foregroundColor(.black)
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct ProductFeature_Previews: PreviewProvider {
    static var previews: some View {
        ProductFeatureCell(feature: .init(title: "Wifi", type: .wifi))
            .preferredColorScheme(.dark)
    }
}
