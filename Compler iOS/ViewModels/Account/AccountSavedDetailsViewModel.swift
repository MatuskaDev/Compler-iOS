//
//  AccountSavedDetailsViewModel.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 02.01.2023.
//

import Foundation

class AccountSavedDetailsViewModel: ObservableObject {
    
    // Textfield bindings
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var street = ""
    @Published var city = ""
    @Published var zip = ""
    @Published var addBillingDetails = false
    @Published var billingFirstName = ""
    @Published var billingLastName = ""
    @Published var billingStreet = ""
    @Published var billingCity = ""
    @Published var billingZip = ""
    @Published var companyName = ""
    @Published var billingCIN = ""
    @Published var billingVAT = ""
    
    init() {
        loadUserSavedDetails()
    }
    
    // Get details from db
    func loadUserSavedDetails() {
        if let user = UserManager.shared.user {
            
            firstName = user.savedShippingInfo?.firstName ?? ""
            lastName = user.savedShippingInfo?.lastName ?? ""
            street = user.savedShippingInfo?.street ?? ""
            city = user.savedShippingInfo?.city ?? ""
            zip = user.savedShippingInfo?.zip ?? ""
            
            addBillingDetails = user.savedAddBillingInfoPreference ?? false
            
            billingFirstName = user.savedBillingInfo?.firstName ?? ""
            billingLastName = user.savedBillingInfo?.lastName ?? ""
            billingStreet = user.savedBillingInfo?.street ?? ""
            billingCity = user.savedBillingInfo?.city ?? ""
            billingZip = user.savedBillingInfo?.zip ?? ""
            companyName = user.savedBillingInfo?.companyName ?? ""
            billingCIN = user.savedBillingInfo?.cin ?? ""
            billingVAT = user.savedBillingInfo?.vat ?? ""
        }
    }
    
    // Save to db
    func save() throws {
        let shippingDetails = Address(firstName: firstName,
                                      lastName: lastName,
                                      street: street,
                                      city: city,
                                      zip: zip)
        
        let billingDetails = !addBillingDetails ? shippingDetails : Address(firstName: billingFirstName,
                                                                            lastName: billingLastName,
                                                                            street: billingStreet,
                                                                            city: billingCity,
                                                                            zip: billingZip,
                                                                            companyName: companyName == "" ? nil : companyName,
                                                                            cin: billingCIN == "" ? nil : billingCIN,
                                                                            vat: billingVAT == "" ? nil : billingVAT)
        var user = UserManager.shared.user!
        user.savedShippingInfo = shippingDetails
        user.savedBillingInfo = billingDetails
        user.savedAddBillingInfoPreference = addBillingDetails
        
        try DatabaseManager.shared.saveUser(user)
    }
}
