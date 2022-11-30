//
//  ProductViewModel.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 09.11.2022.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    var product: Product
    
    var selectedConfiguration: ProductConfiguration? {
        product.configurations.first { p in
            p.memorySize == selectedMemory && p.storageSize == selectedStorage && p.cpuName == selectedCPU && p.gpuName == selectedGPU
        }
    }
    
    init(product: Product) {
        self.product = product
        setup()
    }
    
    // Product configurator bindings
    @Published var selectedMemory: Int?
    @Published var selectedStorage: Int?
    @Published var selectedCPU: String?
    @Published var selectedGPU: String?
    
    // All product options
    var memoryOptions = Set<Int>()
    var storageOptions = Set<Int>()
    var cpuOptions = Set<String>()
    var gpuOptions = Set<String?>()
    
    var sortedCpuOptions: [String] {
        self.cpuOptions.sorted { cpu1, cpu2 in
            let conf1 = product.configurations.first(where: { nt in
                nt.cpuName == cpu1
            })!
            let conf2 = product.configurations.first(where: { nt in
                nt.cpuName == cpu2
            })!
            let score1 = conf1.cpuSingleScore+conf1.cpuMultiScore
            let score2 = conf2.cpuSingleScore+conf2.cpuMultiScore
            
            if score1 == score2 {
                return cpu1 < cpu2
            } else {
                return score1 < score2
            }
        }
    }
    
    private func setup() {
        // Update all product options from product data
        product.configurations.forEach { conf in
            memoryOptions.update(with: conf.memorySize)
            storageOptions.update(with: conf.storageSize)
            cpuOptions.update(with: conf.cpuName)
            gpuOptions.update(with: conf.gpuName)
        }
        
        // Select the cheapest configuration
        let cheapestConf = product.configurations.sorted(by: { n1, n2 in
            n1.price < n2.price
        }).first!
        selectedMemory = cheapestConf.memorySize
        selectedStorage = cheapestConf.storageSize
        selectedCPU = cheapestConf.cpuName
        selectedGPU = cheapestConf.gpuName
    }
    
    // MARK: Product configurator functions
    func isOptionAvailible(memory: Int) -> Bool {
        product.configurations.contains { p in
            p.memorySize == memory && p.storageSize == selectedStorage && p.cpuName == selectedCPU && p.gpuName == selectedGPU
        }
    }
    
    func isOptionAvailible(storage: Int) -> Bool {
        product.configurations.contains { p in
            p.memorySize == selectedMemory && p.storageSize == storage && p.cpuName == selectedCPU && p.gpuName == selectedGPU
        }
    }
    
    func isOptionAvailible(cpu: String) -> Bool {
        product.configurations.contains { p in
            p.memorySize == selectedMemory && p.storageSize == selectedStorage && p.cpuName == cpu && p.gpuName == selectedGPU
        }
    }
    
    func isOptionAvailible(gpu: String?) -> Bool {
        product.configurations.contains { p in
            p.memorySize == selectedMemory && p.storageSize == selectedStorage && p.cpuName == selectedCPU && p.gpuName == gpu
        }
    }
    
    func getOptionPrice(memory: Int? = nil, storage: Int? = nil, cpu: String? = nil, gpu: String? = nil) -> String? {
        
        let configuration = product.configurations.first { p in
            p.memorySize == (memory ?? selectedMemory) &&
            p.storageSize == (storage ?? selectedStorage) &&
            p.cpuName == (cpu ?? selectedCPU) &&
            p.gpuName == (gpu ?? selectedGPU)
        }
        
        if configuration == nil {
            return nil
        } else {
            let price = configuration!.price - (selectedConfiguration?.price ?? 0)
            if price == 0 {
                return nil
            } else {
                return formatOptionPrice(price)
            }
        }
    }
    
    func formatStorageSize(_ size: Int) -> String {
        if size < 1024 {
            return "\(size) GB"
        } else {
            return "\(size/1024) TB"
        }
    }
    
    // MARK: Price formatters
    func formatPrice(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "czk"
        formatter.currencyGroupingSeparator = " "
        formatter.currencyDecimalSeparator = ","
        formatter.minimumFractionDigits = 0
        return formatter.string(from: price as NSNumber)!
    }
    
    private func formatOptionPrice(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "czk"
        formatter.currencyGroupingSeparator = " "
        formatter.currencyDecimalSeparator = ","
        formatter.minimumFractionDigits = 0
        formatter.positivePrefix = "+ "
        formatter.negativePrefix = "- "
        return formatter.string(from: price as NSNumber)!
    }
    
}
