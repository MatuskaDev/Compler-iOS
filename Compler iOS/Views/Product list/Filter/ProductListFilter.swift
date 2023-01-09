//
//  ProductListFilter.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 01.12.2022.
//

import SwiftUI

/// Basic filter for product list
struct ProductListFilter: View {
    
    @ObservedObject var model: ProductListViewModel
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(ProductFocus.allCases, id: \.self) { focus in
                ProductListFilterButton(title: focus.getString,
                                        isSelected: model.filter.contains(focus)) {
                    if model.filter.contains(focus) {
                        model.filter.remove(focus)
                    } else {
                        model.filter.update(with: focus)
                    }
                }
            }
        }
    }
}

struct ProductListFilter_Previews: PreviewProvider {
    static var previews: some View {
        ProductListFilter(model: .init())
            .preferredColorScheme(.dark)
    }
}
