//
//  ProductListView.swift
//  Compler
//
//  Created by Lukáš Matuška on 31.05.2022.
//

import SwiftUI

struct ProductListView: View {
    
    @ObservedObject var model = ProductListViewModel()
    
    var body: some View {
        
        if model.products == nil {
            ProgressView()
        } else {
            List {
                ForEach(model.products!) { product in
                    NavigationLink {
                        ProductDetailView(product: product)
                    } label: {
                        Text(product.modelName)
                    }
                }
            }
            .navigationTitle("Nabídka")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
