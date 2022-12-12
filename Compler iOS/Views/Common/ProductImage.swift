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
    let size: CGFloat
    
    var body: some View {
        
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
            .frame(width: size, height: size)
            .background {
                Color.white
            }
            .cornerRadius(10)
    }
}

struct ProductImage_Previews: PreviewProvider {
    static var previews: some View {
        ProductImage(url: nil, size: 100)
    }
}
