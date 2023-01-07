//
//  CheckoutAddressSection.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 14.12.2022.
//

import SwiftUI

struct AddressInputSection: View {
    
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var street: String
    @Binding var city: String
    @Binding var zip: String

    enum Field {
        case firstName
        case lastName
        case street
        case city
        case zip
    }

    @FocusState var focusedField: Field?
    
    var body: some View {
        
        LabeledVStack("Doručovací adresa") {
            HStack {
                TextField("Jméno", text: $firstName)
                    .focused($focusedField, equals: .firstName)
                    .textContentType(.givenName)
                    .submitLabel(.next)
                
                TextField("Příjmení", text: $lastName)
                    .focused($focusedField, equals: .lastName)
                    .textContentType(.familyName)
                    .submitLabel(.next)
            }

            TextField("Ulice", text: $street)
                .focused($focusedField, equals: .street)
                .textContentType(.streetAddressLine1)
                .submitLabel(.next)

            HStack {
                TextField("Město", text: $city)
                    .focused($focusedField, equals: .city)
                    .textContentType(.addressCity)
                    .submitLabel(.next)

                TextField("PSČ", text: $zip)
                    .focused($focusedField, equals: .zip)
                    .textContentType(.postalCode)
                    .submitLabel(.done)
            }
        }
        .textFieldStyle(OutlineTextFieldStyle())
        .onSubmit {
            switch focusedField {
            case .firstName:
                focusedField = .lastName
            case .lastName:
                focusedField = .street
            case .street:
                focusedField = .city
            case .city:
                focusedField = .zip
            case .zip:
                focusedField = nil
            case .none:
                focusedField = nil
            }
        }
    }
}

struct CheckoutAddressSection_Previews: PreviewProvider {
    static var previews: some View {
        AddressInputSection(firstName: .constant(""), lastName: .constant(""), street: .constant(""), city: .constant(""), zip: .constant(""))
            .preferredColorScheme(.dark)
    }
}
