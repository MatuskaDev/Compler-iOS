//
//  CheckoutBillingSection.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 14.12.2022.
//

import SwiftUI

struct BillingDetailsInputSection: View {
    
    @Binding var companyName: String
    @Binding var cin: String
    @Binding var vat: String
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var street: String
    @Binding var city: String
    @Binding var zip: String

    enum Field {
        case companyName
        case cin
        case vat
        case firstName
        case lastName
        case street
        case city
        case zip
    }

    @FocusState var focusedField: Field?
    
    var body: some View {
        
        LabeledVStack("Fakturační adresa") {
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
            switch focusedField {
            case .companyName:
                focusedField = .cin
            case .cin:
                focusedField = .vat
            case .vat:
                focusedField = .firstName
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

struct CheckoutBillingSection_Previews: PreviewProvider {
    static var previews: some View {
        BillingDetailsInputSection(companyName: .constant(""), cin: .constant(""), vat: .constant(""), firstName: .constant(""), lastName: .constant(""), street: .constant(""), city: .constant(""), zip: .constant(""))
    }
}
