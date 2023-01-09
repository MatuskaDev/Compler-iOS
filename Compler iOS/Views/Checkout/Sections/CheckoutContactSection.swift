//
//  CheckoutContactSection.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 14.12.2022.
//

import SwiftUI

/// Textfield form section with email and phone
struct CheckoutContactSection: View {
    
    @Binding var email: String
    @Binding var phone: String
    
    enum Field: Int {
        case email = 1
        case phone = 2
    }
    @FocusState private var focusedField: Field?
    
    var body: some View {
        
        LabeledVStack("Kontakt") {
            TextField("Email", text: $email)
                .focused($focusedField, equals: .email)
                .textContentType(.emailAddress)
                .submitLabel(.next)
            TextField("Telefon", text: $phone)
                .focused($focusedField, equals: .phone)
                .textContentType(.telephoneNumber)
                .submitLabel(.done)
        }
        .textFieldStyle(OutlineTextFieldStyle())
        .onSubmit {
            focusedField = Field(rawValue: focusedField!.rawValue+1)
        }
    }
}

struct CheckoutContactSection_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutContactSection(email: .constant(""), phone: .constant(""))
    }
}
