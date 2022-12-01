//
//  ProductListFilterButton.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 01.12.2022.
//

import SwiftUI

struct ProductListFilterButton: View {
    
    let title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                action()
            }
        } label: {
            HStack {
                Spacer(minLength: 0)
                Text(title)
                    .fixedSize()
                Spacer(minLength: 0)
            }
        }
        .buttonStyle(OutlineButtonStyle(isSelected: isSelected))

    }
}

struct ProductListFilterButton_Previews: PreviewProvider {
    static var previews: some View {
        ProductListFilterButton(title: "Herní", isSelected: true, action: {})
            .preferredColorScheme(.dark)
    }
}
