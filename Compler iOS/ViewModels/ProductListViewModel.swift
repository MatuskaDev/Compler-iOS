//
//  ProductListViewModel.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 09.11.2022.
//

import Foundation

class ProductListViewModel: ObservableObject {
    
    @Published var products: [Product]?
    
    init() {
        
        DatabaseManager.shared.getProducts { products, error in
            
            guard error == nil else {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                self.products = products
            }
        }
    }
}
