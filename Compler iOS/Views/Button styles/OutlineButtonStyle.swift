//
//  OutlineButtonStyle.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 01.12.2022.
//

import Foundation
import SwiftUI

struct OutlineButtonStyle: ButtonStyle {
    
    var isSelected: Bool
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isSelected ? Color.black : Color.white)
            .padding()
            .background(isSelected ? Color.white : Color.clear)
            .cornerRadius(8)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white)
            }
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .opacity((isEnabled || isSelected) ? 1 : 0.5)
    }
}

struct OutlineButtonStylePreview: PreviewProvider {
    static var previews: some View {
        Button("Test") {
            //
        }
        .buttonStyle(OutlineButtonStyle(isSelected: true))
        .preferredColorScheme(.dark)
    }
}
