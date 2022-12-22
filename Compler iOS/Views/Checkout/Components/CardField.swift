//
//  CardField.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 10.12.2022.
//

import Foundation
import SwiftUI
import Stripe

/// A SwiftUI representation of an STPPaymentCardTextField.
public struct CardField: UIViewRepresentable {
    @Binding var paymentMethodParams: STPPaymentMethodParams?

    /// Initialize a SwiftUI representation of an STPPaymentCardTextField.
    /// - Parameter paymentMethodParams: A binding to the payment card text field's contents.
    /// The STPPaymentMethodParams will be `nil` if the payment card text field's contents are invalid.
    public init(paymentMethodParams: Binding<STPPaymentMethodParams?>) {
        _paymentMethodParams = paymentMethodParams
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    public func makeUIView(context: Context) -> STPPaymentCardTextField {
        let paymentCardField = STPPaymentCardTextField()
        paymentCardField.postalCodeEntryEnabled = false
        
//        if let cardParams = paymentMethodParams?.card {
//            paymentCardField.cardParams = cardParams
//        }
//        if let postalCode = paymentMethodParams?.billingDetails?.address?.postalCode {
//            paymentCardField.postalCode = postalCode
//        }
//        if let countryCode = paymentMethodParams?.billingDetails?.address?.country {
//            paymentCardField.countryCode = countryCode
//        }
        paymentCardField.delegate = context.coordinator
        paymentCardField.setContentHuggingPriority(.required, for: .vertical)
        
        paymentCardField.borderColor = .white
        paymentCardField.cornerRadius = 8
        paymentCardField.expirationPlaceholder = "MM/RR"

        return paymentCardField
    }

    public func updateUIView(_ paymentCardField: STPPaymentCardTextField, context: Context) {
//        if let cardParams = paymentMethodParams?.card {
//            paymentCardField.cardParams = cardParams
//        }
//        if let postalCode = paymentMethodParams?.billingDetails?.address?.postalCode {
//            paymentCardField.postalCode = postalCode
//        }
//        if let countryCode = paymentMethodParams?.billingDetails?.address?.country {
//            paymentCardField.countryCode = countryCode
//        }
    }

    public class Coordinator: NSObject, STPPaymentCardTextFieldDelegate {
        var parent: CardField
        
        init(parent: CardField) {
            self.parent = parent
        }

        public func paymentCardTextFieldDidChange(_ cardField: STPPaymentCardTextField) {
            if !cardField.isValid {
                parent.paymentMethodParams = nil
                return
            }
            
            parent.paymentMethodParams = cardField.paymentMethodParams
        }
    }
}
