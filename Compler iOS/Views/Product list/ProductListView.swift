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
        
        Group {
            if model.filteredProducts == nil {
                ProgressView()
            } else {
                ScrollView {
                    
                    VStack(spacing: 20) {
                        
                        ProductListFilter(model: model)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            ForEach(model.filteredProducts!) { product in
                                NavigationLink {
                                    ProductDetailView(product: product)
                                } label: {
                                    ProductListCard(product: product)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Nabídka")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
