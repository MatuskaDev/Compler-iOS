//
//  CheckoutForm.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 19.12.2022.
//

import SwiftUI

struct CheckoutForm: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var model: CheckoutViewModel
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 30) {
                
                // Product preview
                CheckoutProductPreview(product: model.checkoutProduct)
                
                // Contact details
                CheckoutContactSection(email: $model.email, phone: $model.phone)
                
                // Shipping details
                CheckoutAddressSection(firstName: $model.firstName, lastName: $model.lastName, street: $model.street, city: $model.city, zip: $model.zip)
                
                // Billing details
                Group {
                    Toggle("Doplnit fakturační údaje", isOn: $model.addBillingDetails)
                        .toggleStyle(.switch)
                    
                    if model.addBillingDetails {
                        CheckoutBillingSection(companyName: $model.companyName, cin: $model.billingCIN, vat: $model.billingVAT, firstName: $model.billingFirstName, lastName: $model.billingLastName, street: $model.billingStreet, city: $model.billingCity, zip: $model.billingZip)
                    }
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
                
                // Payment
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
                
                // Error
                if let error = model.error {
                    CheckoutErrorSection(error: error)
                }
                
                // Pay button
                Button {
                    model.pay()
                } label: {
                    if !model.processingOrder {
                        Text("Objednat a zaplatit")
                            .bold()
                    } else {
                        ProgressView()
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

struct CheckoutForm_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutForm()
            .environmentObject(CheckoutViewModel(checkoutProduct: .previewCheckoutProduct))
    }
}
