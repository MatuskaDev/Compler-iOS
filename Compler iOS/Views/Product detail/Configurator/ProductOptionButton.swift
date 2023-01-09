//
//  ProductOption.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 13.11.2022.
//

import SwiftUI

/// Button representing an option in configurator
struct ProductOptionButton: View {
    
    let title: String
    let price: String?
    var colorCode: String? = nil
    
    let isSelected: Bool
    let isAvailible: Bool
    let action: () -> Void
    
    private var color: Color? {
        return colorCode == nil ? nil : Color(hexString: colorCode!)
    }
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                action()
            }
        } label: {
            HStack(spacing: 15) {
                
                // Color icon
                if let color {
                    Circle()
                        .strokeBorder(.white, lineWidth: 4)
                        .background {
                            Circle().fill(color)
                        }
                        .frame(width: 30, height: 30)
                        .shadow(radius: 2)
                }
                
                Text(title)
                
                Spacer()
                
                // Price
                if let price {
                    Text(price)
                        .font(.footnote)
                }
            }
        }
        .buttonStyle(OutlineButtonStyle(isSelected: isSelected))
        .disabled(!isAvailible || isSelected)
    }
}

struct ProductOption_Previews: PreviewProvider {
    static var previews: some View {
        ProductOptionButton(title: "Intel Core i9", price: "+ 10 000 Kč", isSelected: true, isAvailible: true, action: {
            //
        })
            .preferredColorScheme(.dark)
    }
}
