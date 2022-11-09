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
        
        if model.notebookModels == nil {
            ProgressView()
        } else {
            List {
                ForEach(model.notebookModels!.sorted(), id:\.self) { model in
                    NavigationLink {
                        ProductDetailView(model: model)
                    } label: {
                        Text(model)
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
