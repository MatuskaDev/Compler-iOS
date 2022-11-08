//
//  ProductDetailView.swift
//  Compler
//
//  Created by Lukáš Matuška on 31.05.2022.
//

import SwiftUI

struct ProductDetailView: View {
    var body: some View {
        
        VStack {
            ScrollView {
                VStack {
                    Text("Compler Home")
                        .font(.title)
                        .bold()
                    // Product images
                    VStack {
                        Color.gray
                            .frame(height: 300)
                            .cornerRadius(5)
                        HStack {
                            Color.gray
                                .frame(height: 50)
                                .cornerRadius(5)
                            Color.gray
                                .frame(height: 50)
                                .cornerRadius(5)
                            Color.gray
                                .frame(height: 50)
                                .cornerRadius(5)
                            Color.gray
                                .frame(height: 50)
                                .cornerRadius(5)
                        }
                    }
                    
                    // Options
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("Procesor")
                            HStack {
                                Image(systemName: "gear")
                                Text("Intel Core i9")
                                Spacer()
                                Text("+ 10 000 Kč")
                            }
                            .foregroundColor(.black)
                            .padding()
                            .background(.white)
                            .cornerRadius(10)
                            HStack {
                                Image(systemName: "gear")
                                Text("Intel Core i7")
                                Spacer()
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(.green)
                            .cornerRadius(10)
                        }
                        .padding()
                        .background(.gray)
                        .cornerRadius(10)
                        VStack(alignment: .leading) {
                            Text("Grafická karta")
                            HStack {
                                Image(systemName: "gear")
                                Text("Nvidia")
                                Spacer()
                                Text("+ 10 000 Kč")
                            }
                            .foregroundColor(.black)
                            .padding()
                            .background(.white)
                            .cornerRadius(10)
                            HStack {
                                Image(systemName: "gear")
                                Text("AMD")
                                Spacer()
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(.green)
                            .cornerRadius(10)
                        }
                        .padding()
                        .background(.gray)
                        .cornerRadius(10)
                    }
                    .padding(.top)
                    Spacer()
                }
                .padding()
            }
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Cena")
                            Text("29 990 Kč")
                                .bold()
                        }
                        Text("včetně DPH")
                            .font(.caption)
                    }
                    Spacer()
                    VStack {
                        Button {
                            //
                        } label: {
                            Text("Koupit")
                                .foregroundColor(.white)
                                .bold()
                                .padding(10)
                                .padding(.horizontal, 30)
                                .background(.blue)
                                .cornerRadius(10)
                        }
                        Text("Doručení do týdne")
                            .font(.caption)
                    }
                    
                }
            }
            .padding(.horizontal)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView()
            .preferredColorScheme(.dark)
    }
}
