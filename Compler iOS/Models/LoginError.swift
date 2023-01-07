//
//  LoginError.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 07.01.2023.
//

import Foundation

/// Error used in user login
struct LoginError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}
