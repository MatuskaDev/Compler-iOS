//
//  AccountViewModel.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 02.01.2023.
//

import Foundation
import FirebaseAuth

class AccountViewModel: ObservableObject {
    
    @Published var signingOut = false
    
    func signOut() {
        signingOut = true
        Task {
            do {
                try Auth.auth().signOut()
                await UserManager.shared.signInAnonymous()
            } catch {
                print("Error signout")
            }
            
            DispatchQueue.main.async {
                self.signingOut = false
            }
        }
    }
}
