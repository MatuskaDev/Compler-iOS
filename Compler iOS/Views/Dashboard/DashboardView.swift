//
//  DashboardView.swift
//  Compler
//
//  Created by Lukáš Matuška on 25.10.2022.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject var navigationHelper = NavigationHelper()
    
    var body: some View {
        
        NavigationStack(path: $navigationHelper.path) {
            
            VStack {
                
                // Acount card
                NavigationLink(value: Navigation.account) {
                    AccountCard()
                }
                .buttonStyle(.plain)
                
                Spacer()
                
                // Info cards
                CarouselView(cards: [
                    CarouselCard(title: "Compler"),
                    CarouselCard(title: "Je"),
                    CarouselCard(title: "Nejlepší")
                ])
                
                Spacer()
                
                // Navigation
                VStack {
                    
                    NavigationLink("Průvodce výběrem", value: Navigation.recommender)
                    .buttonStyle(LargeButtonStyle())
                    .padding(.horizontal)
                    .frame(maxWidth: 350)
                    
                    HStack(spacing: 10) {
                        Rectangle()
                            .frame(height: 1)
                        Text("nebo")
                        Rectangle()
                            .frame(height: 1)
                    }
                    .padding(8)
                    .frame(maxWidth: 230)
                    
                    NavigationLink("Zobrazit nabídku", value: Navigation.list)
                        .font(.title3)
                }
                
                Spacer()
            }
            .navigationDestination(for: Navigation.self, destination: { nav in
                switch nav {
                case .account:
                    AccountView()
                case .list:
                    ProductListView()
                case .recommender:
                    EmptyView()
                case let .productDetail(product):
                    ProductDetailView(product: product)
                case let .checkout(product):
                    CheckoutView(checkoutProduct: product)
                }
            })
            .background(Color("BackgroundColor"))
        }
        .environmentObject(navigationHelper)
        .preferredColorScheme(.dark)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
