//
//  ProductConfigurator.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 30.11.2022.
//

import SwiftUI

struct ProductConfigurator: View {
    
    @ObservedObject var model: ProductViewModel
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            VStack(alignment: .leading) {
                Text("Barva")
                    .font(.caption)
                    .bold()
                
                ForEach(model.product.colors) { color in
                    ProductOption(title: color.name,
                                  price: nil,
                                  colorIcon: color.hexColorCode,
                                  isSelected: color == model.selectedColor,
                                  isAvailible: true,
                                  action: { model.selectedColor = color })
                }
            }
            .padding(15)
            .background(Color("TertiaryBG"))
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 20) {
                
                // Procesor options
                VStack(alignment: .leading) {
                    
                    Text("Procesor")
                        .font(.caption)
                        .bold()
                    
                    ForEach(model.sortedCpuOptions, id:\.self) { option in
                        ProductOption(title: option,
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
                            ProductOption(title: option ?? "Integrovaná grafická karta",
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
                        ProductOption(title: "\(option) GB",
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
                        ProductOption(title: model.formatStorageSize(option),
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
        }
    }
}

struct ProductConfigurator_Previews: PreviewProvider {
    static var previews: some View {
        ProductConfigurator(model: .init(product: .previewProduct))
            .preferredColorScheme(.dark)
    }
}
