//
//  CheckoutForm.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 19.12.2022.
//

import SwiftUI

/// Checkout form
struct CheckoutForm: View {
    
    @EnvironmentObject var model: CheckoutViewModel
    @ObservedObject var userManager = UserManager.shared
    @EnvironmentObject var navigationHelper: NavigationHelper
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 30) {
                
                // Product preview
                CheckoutProductPreview(product: model.checkoutProduct)
                
                // Checkout sections
                Group {
                    
                    // Account
                    CheckoutAccountSection()
                    
                    // Contact details
                    CheckoutContactSection(email: $model.email, phone: $model.phone)
                    
                    // Shipping details
                    AddressInputSection(firstName: $model.firstName, lastName: $model.lastName, street: $model.street, city: $model.city, zip: $model.zip)
                    
                    // Billing details
                    Group {
                        Toggle("Doplnit fakturační údaje", isOn: $model.addBillingDetails)
                            .toggleStyle(.switch)
                        
                        if model.addBillingDetails {
                            BillingDetailsInputSection(companyName: $model.companyName, cin: $model.billingCIN, vat: $model.billingVAT, firstName: $model.billingFirstName, lastName: $model.billingLastName, street: $model.billingStreet, city: $model.billingCity, zip: $model.billingZip)
                        }
                    }
                    
                    // Save details switch
                    if userManager.isSignedIn() {
                        Toggle("Uložit údaje na příště", isOn: $model.userSaveInfo)
                            .toggleStyle(.switch)
                    }
                    
                    // Shipping
                    LabeledVStack("Způsob doručení") {
                        ForEach(model.availibleShippingMethods ?? []) { shipping in
                            ShippingMethodButton(shippingMethod: shipping,
                                                 isSelected: model.shippingMethod == shipping) {
                                model.shippingMethod = shipping
                            }
                        }
                    }
                    
                    // Payment
                    LabeledVStack("Platba") {
                        Text("Bezpečná platba kartou pomocí Stripe")
                        CardField(paymentMethodParams: $model.paymentMethodParams)
                    }
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
            .disabled(model.processingOrder)
        }
        .background(Color("BackgroundColor"))
        .scrollDismissesKeyboard(.interactively)
        .onChange(of: userManager.isSignedIn()) { isSignedIn in
            if isSignedIn {
                model.loadUserSavedDetails()
            }
        }
        .navigationTitle("Objednávka")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Zrušit") {
                    navigationHelper.path.removeLast()
                }
            }
        }
    }
}

struct CheckoutForm_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutForm()
            .environmentObject(CheckoutViewModel(checkoutProduct: .previewCheckoutProduct))
            .preferredColorScheme(.dark)
    }
}
