//
//  OrderHistoryView.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 02.01.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct OrderHistoryView: View {
    
    @ObservedObject var model = OrderHistoryViewModel()
    
    var body: some View {
        Group {
            if let orders = model.orders {
                List {
                    ForEach(orders) { order in
                        OrderHistoryRow(order: order)
                    }
                }
                .refreshable {
                    await model.loadOrders()
                }
                .scrollContentBackground(.hidden)
            } else {
                ProgressView()
            }
        }
        .background(Color("BackgroundColor"))
        .navigationTitle("Historie objednávek")
    }
}

struct OrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView()
            .preferredColorScheme(.dark)
    }
}
