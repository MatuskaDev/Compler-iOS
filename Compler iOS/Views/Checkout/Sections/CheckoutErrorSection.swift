//
//  CheckoutErrorSection.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 20.12.2022.
//

import SwiftUI

struct CheckoutErrorSection: View {
    
    let error: CustomError
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(error.title)
                    .bold()
                Text(error.description)
            }
            Spacer()
        }
        .padding()
        .background {
            Color.red
        }
        .cornerRadius(8)
    }
}

struct CheckoutErrorSection_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutErrorSection(error: .init(title: "Chyba platby", description: "Nedostatek peněz"))
    }
}
