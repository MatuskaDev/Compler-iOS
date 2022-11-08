//
//  ContentViewModel.swift
//  Compler
//
//  Created by Lukáš Matuška on 08.11.2022.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    @Published var notebooks: [Notebook]?
    
    init() {
        
        // Get notebooks from database
        DatabaseManager.shared.getNotebooks { notebooks, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self.notebooks = notebooks
            }
        }
    }
}
