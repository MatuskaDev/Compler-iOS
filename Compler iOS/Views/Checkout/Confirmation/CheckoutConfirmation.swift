//
//  CheckoutConfirmation.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 19.12.2022.
//

import SwiftUI

/// Order confirmation after sucessful order and payment
struct CheckoutConfirmation: View {
    
    let order: Order
    let product: CheckoutProduct
    
    var title: String {
        if let number = order.number {
            return "Objednávka č. \(number) přijata"
        } else {
            return "Objednávka přijata"
        }
    }
    var statusIcon: String {
        switch order.orderStatus {
        case .processing:
            return "list.bullet.clipboard"
        case .shipped:
            return "shippingbox"
        case .delivered:
            return "person.crop.circle.badge.checkmark"
        case .canceled:
            return "person.crop.circle.badge.xmark"
        }
    }
    var statusTitle: String {
        switch order.orderStatus {
        case .processing:
            return "Připravujeme objednávku"
        case .shipped:
            return "Objednávka odeslána"
        case .delivered:
            return "Objednávka doručena"
        case .canceled:
            return "Objednávka zrušena"
        }
    }
    
    @EnvironmentObject private var navigationHelper: NavigationHelper
    
    var body: some View {
        VStack(spacing: 15) {
            
            // Title
            VStack {
                Text(title)
                    .font(.title2)
                    .bold()
                Text("platba proběhla úspěšně")
            }
            .padding(.top)
            
            Spacer()
            
            CheckoutProductPreview(product: product)
            
            // Order status
            HStack {
                Image(systemName: statusIcon)
                Spacer()
                Text(statusTitle)
                Spacer()
            }
            .padding()
            .background(Color("SecondaryBG"))
            .cornerRadius(8)
            
            Spacer()
            
            // Order details
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                
                ConfirmationSection("Doručovací údaje") {
                    Text("\(order.shippingInfo.firstName) \(order.shippingInfo.lastName)")
                    Text("\(order.shippingInfo.street)")
                    Text("\(order.shippingInfo.city), \(order.shippingInfo.zip)")
                    Spacer(minLength: 0)
                }
                
                ConfirmationSection("Fakturančí údaje") {
                    if let company = order.billingInfo.companyName {
                        Text(company)
                    }
                    Group {
                        if let cin = order.billingInfo.cin {
                            Text("IČ: \(cin)")
                        }
                        if let vat = order.billingInfo.vat {
                            Text("DIČ: \(vat)")
                        }
                    }
                    .font(.caption)
                    Text("\(order.billingInfo.firstName) \(order.billingInfo.lastName)")
                    Text("\(order.billingInfo.street)")
                    Text("\(order.billingInfo.city), \(order.billingInfo.zip)")
                }
                
                ConfirmationSection("Způsob doručení") {
                    Text("PPL")
                }
                
                ConfirmationSection("Celkem") {
                    Text(order.totalAmount.formattedAsPrice)
                }
            }
            
            // Support button
            HStack {
                Spacer()
                Link(destination: URL(string: "mailto:objednavky@compler.cz")!) {
                    Text("Potřebuji pomoct s objednávkou")
                    Image(systemName: "questionmark.circle")
                }
                Spacer()
            }
            
            Spacer()
            
            // Done button
            Button("Hotovo") {
                navigationHelper.path.removeAll()
            }
            .buttonStyle(LargeButtonStyle())
            
        }
        .padding()
        .background(Color("BackgroundColor"))
        .navigationBarHidden(true)
    }
}

struct CheckoutConfirmation_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutConfirmation(order: .previewOrder, product: .previewCheckoutProduct)
            .preferredColorScheme(.dark)
            .environmentObject(NavigationHelper())
    }
}
