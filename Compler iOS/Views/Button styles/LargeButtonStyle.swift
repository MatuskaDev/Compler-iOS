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
        HStack {
            Spacer(minLength: 0)
            configuration.label
            Spacer(minLength: 0)
        }
        .font(.title3.bold())
        .foregroundColor(.white)
        .padding(.vertical)
        .padding(.horizontal, 40)
        .background(Color.accentColor)
        .cornerRadius(100)
    }
}
