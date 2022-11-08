//
//  DashboardView.swift
//  Compler
//
//  Created by Lukáš Matuška on 25.10.2022.
//

import SwiftUI

struct DashboardView: View {
    
    @ObservedObject var model = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("Účet")
            Spacer()
            CarouselView(cards: [
                CarouselCard(title: "Compler"),
                CarouselCard(title: "Compler2")
            ])
            
            Spacer()
            
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
            .foregroundColor(.white)
            
            Button {
                //
            } label: {
                Text("Zobrazit nabídku")
                    .font(.title3)
            }


            Spacer()
        }
        .background(Color.black)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
