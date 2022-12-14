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
    
    // Payment
    @Published var paymentIntentClientSecret: String?
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
    
    @Published var availibleShippingMethods: [ShippingMethod]?
    @Published var shippingMethod: ShippingMethod?
    
    init(checkoutProduct: CheckoutProduct) {
        self.checkoutProduct = checkoutProduct
        loadData()
    }
    
    func loadData() {
        // TODO: Get shipping methods
        availibleShippingMethods = [.init(id: "dfd", title: "PPL", description: "Rychlé doručení až domů", price: 129)]
        shippingMethod = availibleShippingMethods?.first
    }
    
    func startCheckout() {
        Task {
            do {
                let secret = try await StripeManager.shared.getPaymentIntentSecret(amount: checkoutProduct.configuration.price)
                DispatchQueue.main.async {
                    self.paymentIntentClientSecret = secret
                }
            } catch {
                print("Error getting payment intent secret: \(error.localizedDescription)")
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
    
    func createOrder() {
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
        
        let order = Order(product: orderProduct,
                          shippingMethodId: shippingMethod!.id,
                          shippingInfo: shippingDetails,
                          billingInfo: billingDetails,
                          customerId: nil,
                          contactPhone: phone,
                          contactEmail: email)
        
        // TODO: Upload to database
    
    }

    func pay() {
        guard let paymentIntentClientSecret = paymentIntentClientSecret else { return }

        // Collect card details
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: paymentIntentClientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams
        self.paymentIntentParams = paymentIntentParams
        
        // Submit the payment
        self.confirmPayment = true
    }

    func onPaymentComplete(status: STPPaymentHandlerActionStatus, paymentIntent: STPPaymentIntent?, error: Error?) {
        switch status {
        case .succeeded:
            print("Payment succeeded!")
        case .failed:
            print("Payment failed: \(error?.localizedDescription ?? "")")
        case .canceled:
            print("Payment canceled")
        @unknown default:
            print("Unknown status")
        }
    }
}
