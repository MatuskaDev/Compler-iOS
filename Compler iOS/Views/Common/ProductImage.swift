//
//  ProductImage.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 12.12.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductImage: View {
    
    let url: URL?
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundColor(.white)
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(10)
            
            WebImage(url: url)
                .resizable()
                .placeholder {
                    Image(systemName: "laptopcomputer")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .padding(30)
                }
                .scaledToFit()
                .padding()
                .cornerRadius(10)
        }
    }
}

struct ProductImage_Previews: PreviewProvider {
    static var previews: some View {
        ProductImage(url: nil)
            .preferredColorScheme(.dark)
    }
}
