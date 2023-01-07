//
//  CheckoutSection.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 13.12.2022.
//

import SwiftUI

struct LabeledVStack<Content: View>: View {

    var label: String
    var content: Content
    
    init(_ label: String, @ViewBuilder content: () -> Content) {
        self.label = label
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.title)
            content
        }
    }
}

struct CheckoutSection_Previews: PreviewProvider {
    static var previews: some View {
        LabeledVStack("Test") {
            Text("Test")
        }
    }
}
