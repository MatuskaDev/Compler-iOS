//
//  Resolution.swift
//  Compler
//
//  Created by Lukáš Matuška on 08.11.2022.
//

import Foundation

enum Resolution: Codable, Comparable {
    case hd
    case fullHD
    case QHD
    case ultraHD
    
    private var comparisonValue: Int {
      switch self {
          case .hd:
            return 0
          case .fullHD:
            return 1
          case .QHD:
            return 2
          case .ultraHD:
            return 3
      }
    }

    static func >= (lhs: Self, rhs: Self) -> Bool {
      return lhs.comparisonValue >= rhs.comparisonValue
    }
    
    func getString() -> String {
        switch self {
            case .hd:
              return "HD"
            case .fullHD:
              return "Full HD"
            case .QHD:
              return "QHD"
            case .ultraHD:
              return "4K"
        }
    }
}
