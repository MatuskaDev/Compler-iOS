//
//  AccountSavedDetailsView.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 02.01.2023.
//

import SwiftUI

struct AccountSavedDetailsView: View {
    
    @ObservedObject var model = AccountSavedDetailsViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 10) {
            CheckoutAddressSection(firstName: $model.firstName,
                                   lastName: $model.lastName,
                                   street: $model.street,
                                   city: $model.city,
                                   zip: $model.zip)
            
            Toggle("Doplnit fakturační údaje", isOn: $model.addBillingDetails)
                .toggleStyle(.switch)
            
            if model.addBillingDetails {
                CheckoutBillingSection(companyName: $model.companyName, cin: $model.billingCIN, vat: $model.billingVAT, firstName: $model.billingFirstName, lastName: $model.billingLastName, street: $model.billingStreet, city: $model.billingCity, zip: $model.billingZip)
            }
            
            Spacer()
            
            Button {
                do {
                    try model.save()
                    dismiss()
                } catch {
                    print(error.localizedDescription)
                }
            } label: {
                Text("Uložit")
            }
            .buttonStyle(LargeButtonStyle())

        }
        .padding()
        .navigationTitle("Uložené údaje")
        .onAppear {
            model.loadUserSavedDetails()
        }
        .background(Color("BackgroundColor"))
    }
}

struct AccountSavedDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSavedDetailsView()
            .preferredColorScheme(.dark)
    }
}
