//
//  CarouselView.swift
//  Compler
//
//  Created by Lukáš Matuška on 25.10.2022.
//

import SwiftUI

struct CarouselView: View {
    
    @State private var offset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    @State private var currentCard = 0
    
    var cards: [CarouselCard]
    var cardWidth: CGFloat = 250
    var cardHeight: CGFloat = 400
    var spacing: CGFloat = 20
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: spacing) {
                ForEach(cards) { card in
                    card
                    .frame(width: cardWidth, height: cardHeight)
                }
            }
            .offset(x: offset + (geo.size.width-cardWidth)/2)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        offset = value.translation.width + lastOffset
                    })
                    .onEnded({ value in
                        
                        if value.translation.width > 50 && currentCard > 0 {
                            currentCard-=1
                        } else if value.translation.width < -50 {
                            if currentCard < cards.count-1 {
                                currentCard+=1
                            }
                        }
                        
                        withAnimation(.spring()) {
                            offset = CGFloat(currentCard) * -(cardWidth+spacing)
                        }
                        lastOffset = offset
                    })
            )
        }
        .frame(height: cardHeight)
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(cards: [
            CarouselCard(title: "Ahoj"),
            CarouselCard(title: "Cau")
        ])
    }
}
