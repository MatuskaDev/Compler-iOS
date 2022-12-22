//
//  DashboardView.swift
//  Compler
//
//  Created by Lukáš Matuška on 25.10.2022.
//

import SwiftUI

class NavigationHelper: ObservableObject {
    @Published var navigation: Navigation?
    
    enum Navigation {
        case account
        case list
        case recommender
    }
}

struct DashboardView: View {
    
    @ObservedObject var navigationHelper = NavigationHelper()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                // Acount card
                Text("Účet")
                
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
                    
                    Button {
                        //
                    } label: {
                        Text("Průvodce výběrem")
                            .bold()
                    }
                    .buttonStyle(LargeButtonStyle())
                    .padding(.horizontal)
                    
                    HStack(spacing: 10) {
                        Rectangle()
                            .frame(height: 1)
                        Text("nebo")
                        Rectangle()
                            .frame(height: 1)
                    }
                    .padding(8)
                    .frame(maxWidth: 230)
                    
                    NavigationLink(destination: ProductListView(), tag: NavigationHelper.Navigation.list, selection: $navigationHelper.navigation) {
                        Text("Zobrazit nabídku")
                            .font(.title3)
                    }
                }
                
                Spacer()
            }
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
