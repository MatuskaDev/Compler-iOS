//
//  DashboardView.swift
//  Compler
//
//  Created by Lukáš Matuška on 25.10.2022.
//

import SwiftUI

struct DashboardView: View {
    
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
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .padding(.horizontal, 40)
                            .background(Color.accentColor)
                            .cornerRadius(100)
                    }
                    
                    HStack(spacing: 10) {
                        Rectangle()
                            .frame(height: 1)
                        Text("nebo")
                        Rectangle()
                            .frame(height: 1)
                    }
                    .padding(8)
                    .frame(maxWidth: 230)
                    
                    NavigationLink {
                        ProductListView()
                    } label: {
                        Text("Zobrazit nabídku")
                            .font(.title3)
                    }
                }
                
                Spacer()
            }
            .background(Color("BackgroundColor"))
        }
        .preferredColorScheme(.dark)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
