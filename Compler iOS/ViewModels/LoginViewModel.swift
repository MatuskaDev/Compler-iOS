//
//  LoginViewModel.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 29.12.2022.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var name = ""
    @Published var password = ""
    @Published var passwordRepeat = ""
    
    @Published var createNewAccount = false
    @Published var error: String?
    
    @Published var isProcessing = false
    
    func login() {
        self.error = nil
        self.isProcessing = true
        
        Task {
            do {
                if createNewAccount {
                    try await signUp()
                } else {
                    try await signIn()
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = error.localizedDescription
                }
            }
            
            DispatchQueue.main.async {
                self.isProcessing = false
            }
        }
    }
    
    private func signIn() async throws {
        if email != "" && password != "" {
            try await UserManager.shared.signIn(email: email, password: password)
        } else {
            throw LoginError("Vyplňte všechna pole")
        }
    }
    
    private func signUp() async throws {
        if email != "" && name != "" && password != "" && passwordRepeat != "" {
            if password == passwordRepeat {
                try await UserManager.shared.signUp(name: name, email: email, password: password)
            } else {
                throw LoginError("Hesla se neshodují")
            }
        } else {
            throw LoginError("Vyplňte všechna pole")
        }
    }
}


struct LoginError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}
