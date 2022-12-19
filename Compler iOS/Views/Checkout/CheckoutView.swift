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
        
        Group {
            if model.order?.paymentStatus == .paid {
                CheckoutConfirmation()
            } else {
                CheckoutForm()
            }
        }
        .navigationBarBackButtonHidden(true)
        .environmentObject(model)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(checkoutProduct: .previewCheckoutProduct)
            .preferredColorScheme(.dark)
    }
}
