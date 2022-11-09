//
//  ProductListViewModel.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 09.11.2022.
//

import Foundation

class ProductListViewModel: ObservableObject {
    
    @Published var notebookModels: Set<String>?
    
    init() {
        
        DatabaseManager.shared.getNotebookModels { models, error in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self.notebookModels = models
            }
        }
    }
}
