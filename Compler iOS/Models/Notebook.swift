//
//  Computer.swift
//  Compler
//
//  Created by Lukáš Matuška on 08.11.2022.
//

import Foundation

struct Notebook: Identifiable, Codable {
    
    var id: String
    var name: String
    
    var screenSize: Int
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
    
    var model: String {
        return "\(name) \(screenSize)\""
    }
}
