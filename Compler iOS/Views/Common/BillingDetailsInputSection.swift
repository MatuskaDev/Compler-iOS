//
//  CheckoutBillingSection.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 14.12.2022.
//

import SwiftUI

/// Textfield form section with billing details
struct BillingDetailsInputSection: View {
    
    @Binding var companyName: String
    @Binding var cin: String
    @Binding var vat: String
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var street: String
    @Binding var city: String
    @Binding var zip: String

    enum Field: Int {
        case companyName = 1
        case cin = 2
        case vat = 3
        case firstName = 4
        case lastName = 5
        case street = 6
        case city = 7
        case zip = 8
    }
    @FocusState var focusedField: Field?
    
    var body: some View {
        
        LabeledVStack("Fakturační údaje") {
            TextField("Společnost", text: $companyName)
                .focused($focusedField, equals: .companyName)
                .textContentType(.organizationName)
                .submitLabel(.next)
            
            TextField("IČO", text: $cin)
                .focused($focusedField, equals: .cin)
                .submitLabel(.next)
            
            TextField("DIČ", text: $vat)
                .focused($focusedField, equals: .vat)
                .submitLabel(.next)
            
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
            focusedField = Field(rawValue: focusedField!.rawValue+1)
        }
    }
}

struct CheckoutBillingSection_Previews: PreviewProvider {
    static var previews: some View {
        BillingDetailsInputSection(companyName: .constant(""), cin: .constant(""), vat: .constant(""), firstName: .constant(""), lastName: .constant(""), street: .constant(""), city: .constant(""), zip: .constant(""))
    }
}
