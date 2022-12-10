//
//  CheckoutView.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 09.12.2022.
//

import SwiftUI
import StripePaymentSheet
import Stripe
import SDWebImageSwiftUI

struct CheckoutView: View {
    
    @ObservedObject var model: CheckoutViewModel
    
    init(checkoutProduct: CheckoutProduct) {
        self.model = CheckoutViewModel(checkoutProduct: checkoutProduct)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Product preview
            VStack(alignment: .leading, spacing: 10) {
                Text("Produkt")
                    .font(.title)
                HStack {
                    // Product image
                    if model.checkoutProduct.product.mainImageUrl == nil {
                        Image(systemName: "laptopcomputer")
                            .resizable()
                            .scaledToFit()
                            .padding(8)
                            .frame(width: 70, height: 70)
                            .background {
                                Color.gray
                            }
                            .cornerRadius(10)
                    } else {
                        WebImage(url: model.checkoutProduct.product.mainImageUrl)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .cornerRadius(10)
                    }
                    
                    // Product info
                    VStack(alignment: .leading, spacing: 5) {
                        
                        VStack(alignment: .leading) {
                            Text(model.checkoutProduct.product.modelName)
                                .bold()
                            Text(model.checkoutProduct.configuration.formattedPrice)
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("CPU:")
                                    .bold()
                                    .fixedSize()
                                Text(model.checkoutProduct.configuration.cpuName)
                                    .lineLimit(1)
                                
                                if let gpuName = model.checkoutProduct.configuration.gpuName {
                                    Text("GPU:")
                                        .bold()
                                        .fixedSize()
                                    Text(gpuName)
                                        .lineLimit(1)
                                }
                            }
                            HStack {
                                Text("RAM:")
                                    .bold()
                                    .fixedSize()
                                Text(model.checkoutProduct.configuration.formattedMemorySize)
                                    .lineLimit(1)
                                
                                Text("Uložiště:")
                                    .bold()
                                    .fixedSize()
                                Text(model.checkoutProduct.configuration.formattedStorageSize)
                                    .lineLimit(1)
                            }
                        }
                        .font(.caption)
                    }
                    
                    Spacer(minLength: 0)
                }
            }
            
            // Customer details
            Text("Fakturační údaje")
                .font(.title)
            Text("Doručovací adresa")
                .font(.title)
            
            // Shipping
            Text("Způsob doručení")
                .font(.title)
            
            // Payment
            VStack(alignment: .leading, spacing: 10) {
                Text("Platba")
                    .font(.title)
                Text("Bezpečná platba kartou pomocí Stripe")
                CardField(paymentMethodParams: $model.paymentMethodParams)
            }
            Spacer()
            
            // Pay button
            Button {
                model.pay()
            } label: {
                HStack {
                    Spacer()
                    if model.paymentIntentClientSecret != nil {
                        Text("Objednat a zaplatit")
                            .bold()
                    } else {
                        ProgressView()
                    }
                    Spacer()
                }
            }
            .buttonStyle(LargeButtonStyle())
            .paymentConfirmationSheet(isConfirmingPayment: $model.confirmPayment, paymentIntentParams: model.paymentIntentParams, onCompletion: model.onPaymentComplete)
        }
        .padding()
        .onAppear {
            model.startCheckout()
        }
        .navigationTitle("Objednávka")
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(checkoutProduct: .previewCheckoutProduct)
            .preferredColorScheme(.dark)
    }
}
