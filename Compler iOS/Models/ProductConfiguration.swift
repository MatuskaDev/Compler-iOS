//
//  ProductConfiguration.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 30.11.2022.
//

import Foundation

struct ProductConfiguration: Codable, Identifiable, Equatable {
    var id: String
    var screenResolution: Resolution
    var touchScreen: Bool
    var frontCamera: Resolution
    var batteryLife: Int
    var storageSize: Int
    var memorySize: Int
    var cpuName: String
    var cpuSingleScore: Int
    var cpuMultiScore: Int
    var gpuName: String?
    var gpuMemorySize: Int?
    var gpuScore: Int
    var price: Int
    
    var formattedStorageSize: String {
        if storageSize < 1024 {
            return "\(storageSize) GB"
        } else {
            return "\(storageSize/1024) TB"
        }
    }
    var formattedMemorySize: String {
        if memorySize < 1024 {
            return "\(memorySize) GB"
        } else {
            return "\(memorySize/1024) TB"
        }
    }
    
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "czk"
        formatter.currencyGroupingSeparator = " "
        formatter.currencyDecimalSeparator = ","
        formatter.minimumFractionDigits = 0
        return formatter.string(from: price as NSNumber)!
    }
}

extension ProductConfiguration {
    static let previewConfiguration = ProductConfiguration(id: UUID().uuidString,
                                                           screenResolution: .ultraHD,
                                                           touchScreen: false,
                                                           frontCamera: .fullHD,
                                                           batteryLife: 10,
                                                           storageSize: 512,
                                                           memorySize: 16,
                                                           cpuName: "Apple M1 Pro",
                                                           cpuSingleScore: 1000,
                                                           cpuMultiScore: 2000,
                                                           gpuScore: 1000,
                                                           price: 99999)
}
