//
//  CarouselCard.swift
//  Compler
//
//  Created by Lukáš Matuška on 25.10.2022.
//

import SwiftUI

struct CarouselCard: View, Identifiable {
    var id = UUID()
    var title: String
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(20)
                .foregroundColor(.gray)
            Text(title)
        }
    }
}

struct CarouselCard_Previews: PreviewProvider {
    static var previews: some View {
        CarouselCard(title: "Ahoj")
    }
}
