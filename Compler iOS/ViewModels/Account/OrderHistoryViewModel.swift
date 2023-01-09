//
//  OrderHistoryViewModel.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 02.01.2023.
//

import Foundation

class OrderHistoryViewModel: ObservableObject {
    @Published var orders: [Order]?
    
    init() {
        Task {
            await loadOrders()
        }
    }
    
    func loadOrders() async {
        do {
            let orders = try await DatabaseManager.shared.getOrders(userId: UserManager.shared.user!.id).sorted { lhs, rhs in
                lhs.createdAt > rhs.createdAt
            }
            
            DispatchQueue.main.async {
                self.orders = orders
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
