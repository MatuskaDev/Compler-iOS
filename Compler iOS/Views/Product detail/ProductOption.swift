//
//  ProductOption.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 13.11.2022.
//

import SwiftUI

struct ProductOption: View {
    
    let title: String
    let price: String?
    var colorIcon: String? = nil
    var color: Color? {
        if colorIcon != nil {
            return Color(hexString: colorIcon!)
        } else {
            return nil
        }
    }
    
    var isSelected: Bool
    var isAvailible: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                action()
            }
        } label: {
            HStack(spacing: 15) {
                
                if let color = color {
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
                
                if let price = price {
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
        ProductOption(title: "Intel Core i9", price: "+ 10 000 Kč", colorIcon: "#FFFFFF", isSelected: true, isAvailible: true, action: {
            //
        })
            .preferredColorScheme(.dark)
    }
}
