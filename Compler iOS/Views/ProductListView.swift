//
//  ProductListView.swift
//  Compler
//
//  Created by Lukáš Matuška on 31.05.2022.
//

import SwiftUI

struct ProductListView: View {
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            VStack {
                Image("pc")
                    .resizable()
                    .scaledToFit()
                Text("Compler Home")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background()
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
            VStack {
                Image("pc")
                    .resizable()
                    .scaledToFit()
                Text("Compler Home")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background()
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
            VStack {
                Image("pc")
                    .resizable()
                    .scaledToFit()
                Text("Compler Home")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background()
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
