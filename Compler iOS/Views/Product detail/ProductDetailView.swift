//
//  ProductDetailView.swift
//  Compler
//
//  Created by Lukáš Matuška on 31.05.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    
    @ObservedObject var model: ProductViewModel
    
    init(product: Product) {
        self.model = ProductViewModel(product: product)
        
        // Set navigation bar and scroll view background
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(Color("BackgroundColor"))
        UIScrollView.appearance().backgroundColor = UIColor(Color("BackgroundColor"))
        
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
                NavigationLink {
                    if let checkoutProduct = model.getCheckoutProduct() {
                        CheckoutView(checkoutProduct: checkoutProduct)
                    } else {
                        Text("Něco se pokazilo")
                    }
                } label: {
                    Text("Koupit")
                        .foregroundColor(.white)
                        .bold()
                        .padding(8)
                        .padding(.horizontal, 30)
                        .background(Color.accentColor)
                        .cornerRadius(100)
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
