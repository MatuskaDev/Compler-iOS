//
//  OrderHistoryRow.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 02.01.2023.
//

import SwiftUI

struct OrderHistoryRow: View {
    
    var order: Order
    
    var title: String {
        if let number = order.number {
            return "Objednávka č. \(number)"
        } else {
            return "Objednávka"
        }
    }
    
    var status: String {
        switch order.orderStatus {
        case .processing:
            return "Připravujeme"
        case .shipped:
            return "Odesláno"
        case .delivered:
            return "Doručeno"
        case .canceled:
            return "Zrušeno"
        }
    }
    
    var icon: String {
        switch order.orderStatus {
        case .processing:
            return "clock.circle"
        case .shipped:
            return "shippingbox.circle"
        case .delivered:
            return "person.crop.circle.badge.checkmark"
        case .canceled:
            return "xmark.circle"
        }
    }
    
    var date: String {
        order.createdAt.formatted(date: .numeric, time: .omitted)
    }
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40)
            VStack(alignment: .leading) {
                Text(title)
                    .bold()
                Text(status)
            }
            Spacer()
            Text(date)
        }
    }
}

struct OrderHistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryRow(order: .previewOrder)
            .preferredColorScheme(.dark)
    }
}
