//
//  LargeButtonStyle.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 10.12.2022.
//

import Foundation
import SwiftUI

struct LargeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .foregroundColor(.white)
            .padding(.vertical)
            .padding(.horizontal, 40)
            .background(Color.accentColor)
            .cornerRadius(100)
    }
}
