//
//  ProductConfigurator.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 30.11.2022.
//

import SwiftUI

/// Product configurator
struct ProductConfigurator: View {
    
    @ObservedObject var model: ProductViewModel
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            // Color options
            ConfiguratorSection {
                ConfiguratorInnerSection("Barva") {
                    ForEach(model.product.colors) { color in
                        ProductOptionButton(title: color.name,
                                      price: nil,
                                      colorCode: color.hexColorCode,
                                      isSelected: color == model.selectedColor,
                                      isAvailible: true,
                                      action: { model.selectedColor = color })
                    }
                }
            }

            ConfiguratorSection {
                
                // Procesor options
                ConfiguratorInnerSection("Procesor") {
                    ForEach(model.sortedCpuOptions, id:\.self) { option in
                        ProductOptionButton(title: option,
                                      price: model.getOptionPrice(cpu: option),
                                      isSelected: option == model.selectedCPU,
                                      isAvailible: model.isOptionAvailible(cpu: option),
                                      action: { model.selectedCPU = option })
                    }
                }
                
                // Graphics options
                if model.gpuOptions.count > 0 {
                    ConfiguratorInnerSection("Grafická karta") {
                        ForEach(model.gpuOptions.sorted(by: { el1, el2 in
                            el1 ?? "" > el2 ?? ""
                        }), id:\.self) { option in
                            ProductOptionButton(title: option ?? "Integrovaná grafická karta",
                                          price: model.getOptionPrice(gpu: option),
                                          isSelected: option == model.selectedGPU,
                                          isAvailible: model.isOptionAvailible(gpu: option),
                                          action: { model.selectedGPU = option })
                        }
                    }
                }
                
                // Memory options
                ConfiguratorInnerSection("Operační paměť") {
                    ForEach(model.memoryOptions.sorted(by: { el1, el2 in
                        el1 < el2
                    }), id:\.self) { option in
                        ProductOptionButton(title: "\(option) GB",
                                      price: model.getOptionPrice(memory: option),
                                      isSelected: option == model.selectedMemory,
                                      isAvailible: model.isOptionAvailible(memory: option),
                                      action: { model.selectedMemory = option })
                    }
                }
                
                // Storage options
                ConfiguratorInnerSection("Uložiště") {
                    ForEach(model.storageOptions.sorted(by: { el1, el2 in
                        el1 < el2
                    }), id:\.self) { option in
                        ProductOptionButton(title: model.formatStorageSize(option),
                                      price: model.getOptionPrice(storage: option),
                                      isSelected: option == model.selectedStorage,
                                      isAvailible: model.isOptionAvailible(storage: option),
                                      action: { model.selectedStorage = option })
                    }
                }
            }
        }
    }
    
    struct ConfiguratorSection<Content: View>: View {
        @ViewBuilder var content: Content
        var body: some View {
            VStack(alignment: .leading) {
                content
            }
            .padding(15)
            .background(Color("TertiaryBG"))
            .cornerRadius(8)
        }
    }
    
    struct ConfiguratorInnerSection<Content: View>: View {
        var label: String
        var content: Content
        
        init(_ label: String, @ViewBuilder content: () -> Content) {
            self.label = label
            self.content = content()
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                
                Text(label)
                    .font(.caption)
                    .bold()
                
                content
            }
        }
    }
}

struct ProductConfigurator_Previews: PreviewProvider {
    static var previews: some View {
        ProductConfigurator(model: .init(product: .previewProduct))
            .preferredColorScheme(.dark)
    }
}
