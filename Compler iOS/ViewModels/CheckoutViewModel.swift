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
    @Published var error: CustomError?
    
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
    
    @Published var userSaveInfo = true
    
    init(checkoutProduct: CheckoutProduct) {
        self.checkoutProduct = checkoutProduct
        getShippingMethods()
        
        if UserManager.shared.isSignedIn() {
            loadUserSavedDetails()
        }
    }
    
    func loadUserSavedDetails() {
        if let user = UserManager.shared.user {
            
            email = user.email ?? ""
            phone = user.savedPhoneNumber ?? ""
            
            firstName = user.savedShippingInfo?.firstName ?? ""
            lastName = user.savedShippingInfo?.lastName ?? ""
            street = user.savedShippingInfo?.street ?? ""
            city = user.savedShippingInfo?.city ?? ""
            zip = user.savedShippingInfo?.zip ?? ""
            
            addBillingDetails = user.savedAddBillingInfoPreference ?? false
            
            billingFirstName = user.savedBillingInfo?.firstName ?? ""
            billingLastName = user.savedBillingInfo?.lastName ?? ""
            billingStreet = user.savedBillingInfo?.street ?? ""
            billingCity = user.savedBillingInfo?.city ?? ""
            billingZip = user.savedBillingInfo?.zip ?? ""
            companyName = user.savedBillingInfo?.companyName ?? ""
            billingCIN = user.savedBillingInfo?.cin ?? ""
            billingVAT = user.savedBillingInfo?.vat ?? ""
        }
    }
    
    private func getShippingMethods() {
        Task {
            do {
                let shippingMethods = try await DatabaseManager.shared.getShippingMethods()
                
                DispatchQueue.main.async {
                    self.availibleShippingMethods = shippingMethods
                    self.shippingMethod = shippingMethods.first
                }
            } catch {
                print("Error getting shipping methods: \(error.localizedDescription)")
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
                          customerId: UserManager.shared.user?.id,
                          contactPhone: phone,
                          contactEmail: email,
                          totalAmount: getOrderTotal())
        
        return order
    }

    func pay() {
        
        withAnimation {
            self.processingOrder = true
            self.error = nil
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
                try DatabaseManager.shared.saveOrder(order: order)
                
                // Collect card details
                let paymentIntentParams = STPPaymentIntentParams(clientSecret: paymentIntent.secret)
                paymentIntentParams.paymentMethodParams = paymentMethodParams
                self.paymentIntentParams = paymentIntentParams
                
                // Submit the payment
                let saveOrder = order
                DispatchQueue.main.async {
                    self.order = saveOrder
                    self.confirmPayment = true
                }
                
                // Save details for user
                if self.userSaveInfo {
                    var user = UserManager.shared.user!
                    user.savedPhoneNumber = saveOrder.contactPhone
                    user.savedShippingInfo = saveOrder.shippingInfo
                    user.savedAddBillingInfoPreference = self.addBillingDetails
                    user.savedBillingInfo = saveOrder.billingInfo
                    
                    do {
                        try DatabaseManager.shared.saveUser(user)
                    } catch {
                        print("Error saving user details")
                    }
                }
            } catch {
                self.error = CustomError(title: "Objednávku nelze vytvořit", description: error.localizedDescription)
            }
        }
    }

    func onPaymentComplete(status: STPPaymentHandlerActionStatus, paymentIntent: STPPaymentIntent?, error: Error?) {
        
        DispatchQueue.main.async {
            withAnimation {
                if status == .succeeded {
                    self.order?.paymentStatus = .paid
                } else {
                    self.error = CustomError(title: "Chyba platby", description: error?.localizedDescription ?? "")
                }
            }
            self.processingOrder = false
        }
    }
}
