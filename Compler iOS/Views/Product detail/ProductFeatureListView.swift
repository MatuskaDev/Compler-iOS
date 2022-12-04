//
//  ProductFeatureList.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 01.12.2022.
//

import SwiftUI

struct ProductFeatureList: View {
    
    var features: [ProductFeature]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(features) { feature in
                    ProductFeatureCell(feature: feature)
                }
            }
            .padding(15)
        }
    }
}

struct ProductFeatureList_Previews: PreviewProvider {
    static var previews: some View {
        ProductFeatureList(features: [.init(title: "4K rozlišení", type: .display),
                                      .init(title: "výdrž 13 hodin", type: .battery)]
)
            .preferredColorScheme(.dark)
    }
}
