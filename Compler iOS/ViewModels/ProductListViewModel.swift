//
//  ProductListViewModel.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 09.11.2022.
//

import Foundation
import SwiftUI

class ProductListViewModel: ObservableObject {
    
    @Published var products: [Product]?
    @Published var filter = Set<ProductFocus>()
    
    var filteredProducts: [Product]? {
        if filter.isEmpty {
            return products
        } else {
            return products?.filter({ product in
                filter.contains(product.mainFocus)
            })
        }
    }
    
    init() {
        
        Task {
            do {
                let products = try await DatabaseManager.shared.getProducts()
                
                DispatchQueue.main.async {
                    withAnimation {
                        self.products = products
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
