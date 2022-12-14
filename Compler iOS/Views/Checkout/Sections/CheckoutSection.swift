//
//  CheckoutSection.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 13.12.2022.
//

import SwiftUI

struct CheckoutSection<Content: View>: View {

    var title: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
            content
        }
    }
}

struct CheckoutSection_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutSection(title: "Test") {
            Text("Test")
        }
    }
}
