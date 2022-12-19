//
//  CheckoutViewModel.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 09.12.2022.
//

import SwiftUI
import Stripe
import FirebaseFunctions
import StripePaymentSheet

// Stripe checkout view model
class CheckoutViewModel: ObservableObject {
    
    var checkoutProduct: CheckoutProduct
    
    // Status
    @Published var order: Order?
    @Published var processingOrder = false
    @Published var paymentError: String?
    
    // Payment
    @Published var paymentMethodParams: STPPaymentMethodParams?
    @Published var confirmPayment = false
    var paymentIntentParams = STPPaymentIntentParams(clientSecret: "")
    
    // Contact
    @Published var email = ""
    @Published var phone = ""
    
    // Shipping
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var street = ""
    @Published var city = ""
    @Published var zip = ""
    @Published var availibleShippingMethods: [ShippingMethod]?
    @Published var shippingMethod: ShippingMethod?
    
    // Billing
    @Published var addBillingDetails = false
    @Published var billingFirstName = ""
    @Published var billingLastName = ""
    @Published var billingStreet = ""
    @Published var billingCity = ""
    @Published var billingZip = ""
    @Published var companyName = ""
    @Published var billingCIN = ""
    @Published var billingVAT = ""
    
    init(checkoutProduct: CheckoutProduct) {
        self.checkoutProduct = checkoutProduct
        getShippingMethods()
    }
    
    private func getShippingMethods() {
        DatabaseManager.shared.getShippingMethods { methods, error in
            if let methods = methods {
                DispatchQueue.main.async {
                    self.availibleShippingMethods = methods
                    self.shippingMethod = methods.first
                }
            } else {
                print("Error getting shipping methods: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    func canCreateOrder() -> Bool {
        if addBillingDetails {
            return email != "" && phone != "" && firstName != "" && lastName != "" && street != "" && city != "" && zip != "" && billingFirstName != "" && billingLastName != "" && billingStreet != "" && billingCity != "" && billingZip != ""  && shippingMethod != nil
        } else {
            return email != "" && phone != "" && firstName != "" && lastName != "" && street != "" && city != "" && zip != "" && shippingMethod != nil
        }
    }
    
    func getOrderTotal() -> Int {
        checkoutProduct.configuration.price + (shippingMethod?.price ?? 0)
    }
    
    private func createOrder() -> Order {
        
        let orderProduct = OrderProduct(productId: checkoutProduct.product.id,
                                        configurationId: checkoutProduct.configuration.id,
                                        colorId: checkoutProduct.color.id)
        
        let shippingDetails = Address(firstName: firstName,
                                      lastName: lastName,
                                      street: street,
                                      city: city,
                                      zip: zip)
        
        let billingDetails = !addBillingDetails ? shippingDetails : Address(firstName: billingFirstName,
                                                                            lastName: billingLastName,
                                                                            street: billingStreet,
                                                                            city: billingCity,
                                                                            zip: billingZip,
                                                                            companyName: companyName == "" ? nil : companyName,
                                                                            cin: billingCIN == "" ? nil : billingCIN,
                                                                            vat: billingVAT == "" ? nil : billingVAT)
        
        let order = Order(id: self.order?.id ?? UUID().uuidString,
                          number: self.order?.number,
                          product: orderProduct,
                          shippingMethodId: shippingMethod!.id,
                          shippingInfo: shippingDetails,
                          billingInfo: billingDetails,
                          customerId: nil,
                          contactPhone: phone,
                          contactEmail: email,
                          totalAmount: getOrderTotal())
        
        return order
    }

    func pay() {
        
        withAnimation {
            self.processingOrder = true
            self.paymentError = nil
        }
        
        Task {
            
            do {
                // Create order and payment intent
                var order = createOrder()
                let paymentIntent = try await StripeManager.shared.getPaymentIntent(orderId: order.id, amount: order.totalAmount)
                order.paymentId = paymentIntent.id
                
                // Set order number
                if order.number == nil {
                    order.number = try await DatabaseManager.shared.getOrderNumber()
                }
                
                // Save order
                self.order = order
                try DatabaseManager.shared.saveOrder(order: order)
                
                // Collect card details
                let paymentIntentParams = STPPaymentIntentParams(clientSecret: paymentIntent.secret)
                paymentIntentParams.paymentMethodParams = paymentMethodParams
                self.paymentIntentParams = paymentIntentParams
                
                // Submit the payment
                DispatchQueue.main.async {
                    self.confirmPayment = true
                }
            } catch {
                print("Error \(error.localizedDescription)")
            }
        }
    }

    func onPaymentComplete(status: STPPaymentHandlerActionStatus, paymentIntent: STPPaymentIntent?, error: Error?) {
        
        withAnimation {
            if status == .succeeded {
                self.order?.paymentStatus = .paid
            } else {
                paymentError = error?.localizedDescription
            }
        }
        self.processingOrder = false
    }
}
