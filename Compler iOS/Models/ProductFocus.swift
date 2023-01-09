//
//  ProductFocus.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 01.12.2022.
//

import Foundation

enum ProductFocus: Codable, CaseIterable, Hashable {
    case games
    case office
    case creative
}

extension ProductFocus {
    var getString: String {
        switch self {
        case .games:
            return "Herní"
        case .office:
            return "Kancelářské"
        case .creative:
            return "Výkonné"
        }
    }
    
    var getIconName: String {
        switch self {
        case .games:
            return "gamecontroller"
        case .office:
            return "house"
        case .creative:
            return "bolt.fill"
        }
    }
}
