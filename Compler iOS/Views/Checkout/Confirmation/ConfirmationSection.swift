//
//  ConfirmationSection.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 22.12.2022.
//

import SwiftUI

struct ConfirmationSection<Content: View>: View {
    
    let title: String
    @ViewBuilder var content: Content
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
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
        ConfirmationSection(title: "Test") {
            Text("Ahoj")
        }
    }
}
