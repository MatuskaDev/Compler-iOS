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
    @Published var paymentIntentClientSecret: String?
    @Published var paymentMethodParams: STPPaymentMethodParams?
    
    @Published var confirmPayment = false
    var paymentIntentParams = STPPaymentIntentParams(clientSecret: "")
    
    init(checkoutProduct: CheckoutProduct) {
        self.checkoutProduct = checkoutProduct
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
