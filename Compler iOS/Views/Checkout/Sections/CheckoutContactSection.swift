//
//  CheckoutContactSection.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 14.12.2022.
//

import SwiftUI

struct CheckoutContactSection: View {
    
    @Binding var email: String
    @Binding var phone: String
    
    enum Field {
        case email
        case phone
    }

    @FocusState private var focusedField: Field?
    
    var body: some View {
        
        CheckoutSection(title: "Kontakt") {
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
            switch focusedField {
            case .email:
                focusedField = .phone
            case .phone:
                focusedField = nil
            case .none:
                focusedField = nil
            }
        }
    }
}

struct CheckoutContactSection_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutContactSection(email: .constant(""), phone: .constant(""))
    }
}
