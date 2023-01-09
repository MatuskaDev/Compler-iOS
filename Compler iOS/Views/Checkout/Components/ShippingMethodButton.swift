//
//  ShippingMethodButton.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 13.12.2022.
//

import SwiftUI

/// Button representing an shipping method
struct ShippingMethodButton: View {
    
    let shippingMethod: ShippingMethod
    
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                action()
            }
        } label: {
            VStack(alignment: .leading) {
                HStack {
                    Text(shippingMethod.title)
                        .bold()
                    Spacer(minLength: 0)
                    Text(shippingMethod.price.formattedAsPrice)
                }
                Text(shippingMethod.description)
            }
        }
        .buttonStyle(OutlineButtonStyle(isSelected: isSelected))
        .disabled(isSelected)
    }
}

struct ShippingMethodButton_Previews: PreviewProvider {
    static var previews: some View {
        ShippingMethodButton(shippingMethod: .init(id: "", title: "", description: "", price: 0), isSelected: false) {
            //
        }
        .preferredColorScheme(.dark)
    }
}
