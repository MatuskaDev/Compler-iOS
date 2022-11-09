//
//  ProductOption.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 13.11.2022.
//

import SwiftUI

struct ProductOption: View {
    
    let icon: String
    let title: String
    let price: String?
    
    var isSelected: Bool
    var isAvailible: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            HStack {
                Text(title)
                Spacer()
                if let price = price {
                    Text(price)
                        .font(.footnote)
                }
            }
            .foregroundColor(isSelected ? Color.black : Color.white)
            .padding()
            .background(isSelected ? Color.white : Color.clear)
            .cornerRadius(8)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white)
            }
            .contentShape(RoundedRectangle(cornerRadius: 8))
        }
        .buttonStyle(.plain)
        .disabled(!isAvailible)
    }
}

struct ProductOption_Previews: PreviewProvider {
    static var previews: some View {
        ProductOption(icon: "gear", title: "Intel Core i9", price: "+ 10 000 Kč", isSelected: false, isAvailible: true, action: {
            //
        })
            .preferredColorScheme(.dark)
    }
}
