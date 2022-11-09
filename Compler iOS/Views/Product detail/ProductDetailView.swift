//
//  ProductDetailView.swift
//  Compler
//
//  Created by Lukáš Matuška on 31.05.2022.
//

import SwiftUI

struct ProductDetailView: View {
    
    @ObservedObject var model: ProductViewModel
    
    init(model: String) {
        self.model = ProductViewModel(model: model)
        
        // Set navigation bar and scroll view background
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(Color("BackgroundColor"))
        UIScrollView.appearance().backgroundColor = UIColor(Color("BackgroundColor"))
    }
    
    var body: some View {
        
        if model.loading || model.notebook == nil {
            ProgressView()
                .onAppear {
                    model.loadData()
                }
            
        } else {
            
            VStack(spacing: 0) {
                
                ScrollView {
                    
                    VStack {
                        
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
                        VStack(alignment: .leading, spacing: 20) {
                            
                            // Procesor options
                            VStack(alignment: .leading) {
                                
                                Text("Procesor")
                                    .font(.caption)
                                    .bold()
                                
                                ForEach(model.sortedCpuOptions, id:\.self) { option in
                                    ProductOption(icon: "gear",
                                                  title: option,
                                                  price: model.getOptionPrice(cpu: option),
                                                  isSelected: option == model.selectedCPU,
                                                  isAvailible: model.isOptionAvailible(cpu: option),
                                                  action: { model.selectedCPU = option })
                                }
                            }
                            
                            // Graphics options
                            if model.gpuOptions.count > 0 {
                                VStack(alignment: .leading) {
                                    
                                    Text("Grafická karta")
                                        .font(.caption)
                                        .bold()
                                    
                                    ForEach(model.gpuOptions.sorted(by: { el1, el2 in
                                        el1 ?? "" > el2 ?? ""
                                    }), id:\.self) { option in
                                        ProductOption(icon: "gear",
                                                      title: option ?? "Integrovaná grafická karta",
                                                      price: model.getOptionPrice(gpu: option),
                                                      isSelected: option == model.selectedGPU,
                                                      isAvailible: model.isOptionAvailible(gpu: option),
                                                      action: { model.selectedGPU = option })
                                    }
                                }
                            }
                            
                            // Memory options
                            VStack(alignment: .leading) {
                                
                                Text("Operační paměť")
                                    .font(.caption)
                                    .bold()
                                
                                ForEach(model.memoryOptions.sorted(by: { el1, el2 in
                                    el1 < el2
                                }), id:\.self) { option in
                                    ProductOption(icon: "gear",
                                                  title: "\(option) GB",
                                                  price: model.getOptionPrice(memory: option),
                                                  isSelected: option == model.selectedMemory,
                                                  isAvailible: model.isOptionAvailible(memory: option),
                                                  action: { model.selectedMemory = option })
                                }
                            }
                            
                            // Storage options
                            VStack(alignment: .leading) {
                                
                                Text("Uložiště")
                                    .font(.caption)
                                    .bold()
                                
                                ForEach(model.storageOptions.sorted(by: { el1, el2 in
                                    el1 < el2
                                }), id:\.self) { option in
                                    ProductOption(icon: "gear",
                                                  title: model.formatStorageSize(option),
                                                  price: model.getOptionPrice(storage: option),
                                                  isSelected: option == model.selectedStorage,
                                                  isAvailible: model.isOptionAvailible(storage: option),
                                                  action: { model.selectedStorage = option })
                                }
                            }
                        }
                        .padding(15)
                        .background(Color("TertiaryBG"))
                        .cornerRadius(8)
                        .padding(.top)
                        
                        Spacer()
                    }
                    .padding()
                }
                
                // Bottom bar
                HStack {
                    
                    // Price
                    VStack(alignment: .leading) {
                        
                        Text(model.formatPrice(model.notebook!.price))
                            .font(.title3)
                            .bold()
                        
                        Text("včetně DPH")
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    // Buy
                    VStack {
                        Button {
                            //
                        } label: {
                            Text("Koupit")
                                .foregroundColor(.white)
                                .bold()
                                .padding(8)
                                .padding(.horizontal, 30)
                                .background(Color.accentColor)
                                .cornerRadius(100)
                        }
                        Text("Doručení do týdne")
                            .font(.caption)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top)
                .background(Color("SecondaryBG"))
            }
            .navigationTitle(model.notebook!.model)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(model: "Macbook Pro 14\"")
            .preferredColorScheme(.dark)
    }
}
