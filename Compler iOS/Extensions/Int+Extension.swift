//
//  Int+Extension.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 13.12.2022.
//

import Foundation

extension Int {
    var formattedAsPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "czk"
        formatter.currencyGroupingSeparator = " "
        formatter.currencyDecimalSeparator = ","
        formatter.minimumFractionDigits = 0
        return formatter.string(from: self as NSNumber)!
    }
}
