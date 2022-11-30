//
//  ProductDetailView.swift
//  Compler
//
//  Created by Lukáš Matuška on 31.05.2022.
//

import SwiftUI

struct ProductDetailView: View {
    
    @ObservedObject var model: ProductViewModel
    
    init(product: Product) {
        self.model = ProductViewModel(product: product)
        
        // Set navigation bar and scroll view background
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(Color("BackgroundColor"))
        UIScrollView.appearance().backgroundColor = UIColor(Color("BackgroundColor"))
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            ScrollView {
                
                VStack {
                    
                    // Product images
                    VStack {
                        Color.gray
                            .frame(height: 300)
                            .cornerRadius(5)
                        HStack {
                            Color.gray
                                .frame(height: 50)
                                .cornerRadius(5)
                            Color.gray
                                .frame(height: 50)
                                .cornerRadius(5)
                            Color.gray
                                .frame(height: 50)
                                .cornerRadius(5)
                            Color.gray
                                .frame(height: 50)
                                .cornerRadius(5)
                        }
                    }
                    
                    ProductConfigurator(model: model)
                    
                    Spacer()
                }
                .padding()
            }
            
            // Bottom bar
            HStack {
                
                // Price
                VStack(alignment: .leading) {
                    
                    Text(model.formatPrice(model.selectedConfiguration?.price ?? 0))
                        .font(.title3)
                        .bold()
                    
                    Text("včetně DPH")
                        .font(.caption)
                }
                
                Spacer()
                
                // Buy
                VStack {
                    Button {
                        //
                    } label: {
                        Text("Koupit")
                            .foregroundColor(.white)
                            .bold()
                            .padding(8)
                            .padding(.horizontal, 30)
                            .background(Color.accentColor)
                            .cornerRadius(100)
                    }
                    Text("Doručení do týdne")
                        .font(.caption)
                }
            }
            .padding(.horizontal, 30)
            .padding(.top)
            .background(Color("SecondaryBG"))
        }
        .navigationTitle(model.product.modelName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: .previewProduct)
            .preferredColorScheme(.dark)
    }
}
