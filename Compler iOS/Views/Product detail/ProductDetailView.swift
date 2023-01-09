//
//  ProductDetailView.swift
//  Compler
//
//  Created by Lukáš Matuška on 31.05.2022.
//

import SwiftUI
import SDWebImageSwiftUI

/// Product detail view with configurator
struct ProductDetailView: View {
    
    @ObservedObject var model: ProductDetailViewModel
    
    init(product: Product) {
        model = ProductDetailViewModel(product: product)
        
        // Set tab view page indicator color
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("BackgroundColor"))
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color("BackgroundColor")).withAlphaComponent(0.2)
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
                
            ScrollView {
                
                VStack(spacing: 10) {
                    
                    // Product images
                    TabView {
                
                        // Product images with selected color
                        if model.selectedColor?.imagesUrl != nil {
                            ForEach(model.selectedColor!.imagesUrl!, id:\.self) { image in
                                ProductImage(url: image)
                                    .padding(.horizontal, 15)
                            }
                        }
                        // Show main image
                        else {
                            ProductImage(url: model.product.mainImageUrl)
                                .padding(.horizontal, 15)
                        }
                    }
                    .tabViewStyle(.page)
                    .aspectRatio(1, contentMode: .fit)
                    
                    // Product features
                    if let features = model.product.features {
                        ProductFeatureList(features: features)
                    }
                    
                    // Product configurator
                    ProductConfigurator(model: model)
                        .padding(.horizontal, 15)
                    
                    Spacer()
                }
            }
            .background(Color("BackgroundColor"))
            
            // Bottom bar
            HStack {
                
                // Price
                if let price = model.selectedConfiguration?.price {
                    VStack(alignment: .leading) {
                        
                        Text(price.formattedAsPrice)
                            .font(.title3)
                            .bold()
                        
                        Text("včetně DPH")
                            .font(.caption)
                    }
                }
                
                Spacer()
                
                // Buy
                NavigationLink("Koupit", value: Navigation.checkout(model.getCheckoutProduct()!))
                    .foregroundColor(.white)
                    .bold()
                    .padding(8)
                    .padding(.horizontal, 30)
                    .background(Color.accentColor)
                    .cornerRadius(100)
            }
            .padding(.horizontal, 30)
            .padding(.top)
            .background(Color("SecondaryBG"))
        }
        .navigationTitle("\(model.product.brand) \(model.product.modelName)")
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: .previewProduct)
            .preferredColorScheme(.dark)
    }
}
