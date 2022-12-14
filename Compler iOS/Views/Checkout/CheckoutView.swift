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
    @Environment(\.dismiss) var dismiss
    
    init(checkoutProduct: CheckoutProduct) {
        self.model = CheckoutViewModel(checkoutProduct: checkoutProduct)
    }
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 30) {
                
                // Product preview
                CheckoutProductPreview(product: model.checkoutProduct)
                
                // Contact details
                CheckoutContactSection(email: $model.email, phone: $model.phone)
                
                // Shipping details
                CheckoutAddressSection(firstName: $model.firstName, lastName: $model.lastName, street: $model.street, city: $model.city, zip: $model.zip)
                
                
                Toggle("Doplnit fakturační údaje", isOn: $model.addBillingDetails)
                    .toggleStyle(.switch)
                
                if model.addBillingDetails {
                    CheckoutBillingSection(companyName: $model.companyName, cin: $model.billingCIN, vat: $model.billingVAT, firstName: $model.billingFirstName, lastName: $model.billingLastName, street: $model.billingStreet, city: $model.billingCity, zip: $model.billingZip)
                }
                
                // Shipping
                CheckoutSection(title: "Způsob doručení") {
                    ForEach(model.availibleShippingMethods ?? []) { shipping in
                        ShippingMethodButton(shippingMethod: shipping,
                                             isSelected: model.shippingMethod == shipping) {
                            model.shippingMethod = shipping
                        }
                    }
                }
                
                CheckoutSection(title: "Platba") {
                    Text("Bezpečná platba kartou pomocí Stripe")
                    CardField(paymentMethodParams: $model.paymentMethodParams)
                }

                Spacer()
                
                // Total
                HStack {
                    Spacer()
                    Text("Celkem \(model.getOrderTotal().formattedAsPrice)")
                        .font(.title2)
                    Spacer()
                }
                
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
                .disabled(!model.canCreateOrder())
                .buttonStyle(LargeButtonStyle())
                .paymentConfirmationSheet(isConfirmingPayment: $model.confirmPayment, paymentIntentParams: model.paymentIntentParams, onCompletion: model.onPaymentComplete)
            }
            .padding()
        }
        .onTapGesture {
            UIApplication.shared.windows.forEach { $0.endEditing(false) }
        }
        .onAppear {
            model.startCheckout()
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Objednávka")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Zrušit") {
                    dismiss()
                }
            }
        }
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(checkoutProduct: .previewCheckoutProduct)
            .preferredColorScheme(.dark)
    }
}
