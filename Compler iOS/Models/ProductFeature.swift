//
//  Feature.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 04.12.2022.
//

import Foundation

struct ProductFeature: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    let title: String
    let type: FeatureType
    
    enum FeatureType: Codable {
        case display
        case battery
        case camera
        case brightness
        case wifi
        case bluetooth
        case biometry
        case connector
    }
    
    var icon: String {
        switch type {
        case .display:
            return "display"
        case .battery:
            return "battery.100"
        case .camera:
            return "web.camera.fill"
        case .brightness:
            return "sun.max"
        case .wifi:
            return "wifi"
        case .bluetooth:
            return "app.connected.to.app.below.fill"
        case .biometry:
            return "touchid"
        case .connector:
            return "cable.connector"
        }
    }
}
