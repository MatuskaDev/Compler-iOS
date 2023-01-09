//
//  ConfirmationSection.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 22.12.2022.
//

import SwiftUI

struct ConfirmationSection<Content: View>: View {
    
    let label: String
    var content: Content
    
    init(_ label: String, @ViewBuilder content: () -> Content) {
        self.label = label
        self.content = content()
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(label)
                    .bold()
                    .fixedSize()
                    .padding(.bottom, 2)
                content
            }
            Spacer()
        }
        .padding()
        .background(Color("SecondaryBG"))
        .cornerRadius(8)
    }
}

struct ConfirmationSection_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationSection("Test") {
            Text("Ahoj")
        }
    }
}
