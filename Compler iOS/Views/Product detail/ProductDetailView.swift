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
        
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("BackgroundColor"))
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color("BackgroundColor")).withAlphaComponent(0.2)
    }
    
    @State var showCheckout = false
    
    var body: some View {
        
        VStack(spacing: 0) {
                
            GeometryReader { geo in
                
                ScrollView {
                    
                    VStack(spacing: 20) {
                        
                        // Product images
                        TabView {
                            
                            // Main image
                            ProductImage(url: model.product.mainImageUrl, size: geo.size.width-30)
                            
                            // Additional images
                            if model.selectedColor?.imagesUrl != nil {
                                ForEach(model.selectedColor!.imagesUrl!, id:\.self) { image in
                                    ProductImage(url: image, size: geo.size.width-30)
                                }
                            }
                        }
                        .frame(height: geo.size.width-30)
                        .tabViewStyle(.page)
                        
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
                        showCheckout.toggle()
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
            .sheet(isPresented: $showCheckout) {
                if let checkoutProduct = model.getCheckoutProduct() {
                    CheckoutView(checkoutProduct: checkoutProduct)
                } else {
                    Text("Něco se pokazilo")
                }
            }
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
