//
//  UserManager.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 27.12.2022.
//

import Foundation
import FirebaseAuth
import SwiftUI

class UserManager: ObservableObject {
    @Published var user: User?
    
    static let shared = UserManager()
    private init() {
        Task {
            if let currentUser = Auth.auth().currentUser {
                do {
                    let user = try await DatabaseManager.shared.getUser(id: currentUser.uid)
                    DispatchQueue.main.async {
                        self.user = user
                    }
                } catch {
                    print(error.localizedDescription)
                    await signInAnonymous()
                }
            } else {
                // Sign in anonymous user
                await signInAnonymous()
            }
        }
    }
    
    func signInAnonymous() async {
        do {
            let result = try await Auth.auth().signInAnonymously()
            DispatchQueue.main.async {
                self.user = User(id: result.user.uid, isAnonymous: true)
                print("Create anonymous user")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func signUp(name: String, email: String, password: String) async throws {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        try await Auth.auth().currentUser?.link(with: credential)
        let user = User(id: Auth.auth().currentUser!.uid, email: email, name: name)
        try DatabaseManager.shared.saveUser(user)
        DispatchQueue.main.async {
            self.user = user
        }
        print("Sign up succesful")
    }
    
    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
        Task {
            let user = try await DatabaseManager.shared.getUser(id: Auth.auth().currentUser!.uid)
            DispatchQueue.main.async {
                self.user = user
            }
        }
        print("Sign in succesful")
    }
    
    func isSignedIn() -> Bool {
        if user?.isAnonymous ?? true {
            return false
        } else {
            return true
        }
    }
}
