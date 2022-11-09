//
//  ProductViewModel.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 09.11.2022.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    private let model: String
    var configurations: [Notebook]?
    
    var loading: Bool {
        configurations == nil
    }
    
    @Published var selectedMemory: Int?
    @Published var selectedStorage: Int?
    @Published var selectedCPU: String?
    @Published var selectedGPU: String?
    
    var memoryOptions = Set<Int>()
    var storageOptions = Set<Int>()
    var cpuOptions = Set<String>()
    var gpuOptions = Set<String?>()
    
    init(model: String) {
        self.model = model
        loadData()
    }
    
    func loadData() {
        DatabaseManager.shared.getConfigurationsFor(model: model) { conf, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let conf = conf {
                DispatchQueue.main.async {
                    self.configurations = conf
                    self.setup()
                }
            }
        }
    }
    
    private func setup() {
        configurations!.forEach { conf in
            memoryOptions.update(with: conf.memorySize)
            storageOptions.update(with: conf.storageSize)
            cpuOptions.update(with: conf.cpuName)
            gpuOptions.update(with: conf.gpuName)
        }
        
        // Select the cheapest configuration
        let cheapestConf = configurations!.sorted(by: { n1, n2 in
            n1.price < n2.price
        }).first!
        selectedMemory = cheapestConf.memorySize
        selectedStorage = cheapestConf.storageSize
        selectedCPU = cheapestConf.cpuName
        selectedGPU = cheapestConf.gpuName
    }
    
    var notebook: Notebook? {
        configurations?.first { notebook in
            notebook.memorySize == selectedMemory && notebook.storageSize == selectedStorage && notebook.cpuName == selectedCPU && notebook.gpuName == selectedGPU
        }
    }
    
    func isOptionAvailible(memory: Int) -> Bool {
        configurations?.contains { notebook in
            notebook.memorySize == memory && notebook.storageSize == selectedStorage && notebook.cpuName == selectedCPU && notebook.gpuName == selectedGPU
        } ?? false
    }
    
    func isOptionAvailible(storage: Int) -> Bool {
        configurations?.contains { notebook in
            notebook.memorySize == selectedMemory && notebook.storageSize == storage && notebook.cpuName == selectedCPU && notebook.gpuName == selectedGPU
        } ?? false
    }
    
    func isOptionAvailible(cpu: String) -> Bool {
        configurations?.contains { notebook in
            notebook.memorySize == selectedMemory && notebook.storageSize == selectedStorage && notebook.cpuName == cpu && notebook.gpuName == selectedGPU
        } ?? false
    }
    
    func isOptionAvailible(gpu: String?) -> Bool {
        configurations?.contains { notebook in
            notebook.memorySize == selectedMemory && notebook.storageSize == selectedStorage && notebook.cpuName == selectedCPU && notebook.gpuName == gpu
        } ?? false
    }
    
    func getOptionPrice(memory: Int? = nil, storage: Int? = nil, cpu: String? = nil, gpu: String? = nil) -> String? {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "czk"
        formatter.currencyGroupingSeparator = " "
        formatter.currencyDecimalSeparator = ","
        formatter.minimumFractionDigits = 0
        formatter.positivePrefix = "+ "
        formatter.negativePrefix = "- "
        
        let notebookWithOption = configurations?.first { notebook in
            notebook.memorySize == (memory ?? selectedMemory) &&
            notebook.storageSize == (storage ?? selectedStorage) &&
            notebook.cpuName == (cpu ?? selectedCPU) &&
            notebook.gpuName == (gpu ?? selectedGPU)
        }
        
        if notebookWithOption == nil {
            return nil
        } else {
            let price = notebookWithOption!.price - (notebook?.price ?? 0)
            if price == 0 {
                return nil
            } else {
                return formatter.string(from: price as NSNumber)!
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
    
    var sortedCpuOptions: [String] {
        self.cpuOptions.sorted { cpu1, cpu2 in
            let conf1 = configurations!.first(where: { nt in
                nt.cpuName == cpu1
            })!
            let conf2 = configurations!.first(where: { nt in
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
    
    func formatPrice(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "czk"
        formatter.currencyGroupingSeparator = " "
        formatter.currencyDecimalSeparator = ","
        formatter.minimumFractionDigits = 0
        return formatter.string(from: price as NSNumber)!
    }
    
}
