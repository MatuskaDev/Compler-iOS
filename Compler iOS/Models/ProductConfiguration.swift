//
//  ProductConfiguration.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 30.11.2022.
//

import Foundation

struct ProductConfiguration: Codable, Identifiable, Hashable {
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
