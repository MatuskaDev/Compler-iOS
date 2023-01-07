//
//  AccountDashboardView.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 02.01.2023.
//

import SwiftUI

/// Dashboard for signed in user
struct AccountDashboardView: View {
    
    @ObservedObject var userManager = UserManager.shared
    @State var signingOut = false
    
    var body: some View {
        VStack(spacing: 15) {
            
            // Logo and title
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                Text("Compler účet")
                    .font(.title.bold())
            }
            
            // User name and email
            VStack {
                if let name = userManager.user?.name {
                    Text(name)
                        .bold()
                }
                if let email = userManager.user?.email {
                    Text(email)
                }
            }
            
            // Menu
            ColoredList {
                NavigationLink("Historie objednávek") {
                    OrderHistoryView()
                }
                
                Section {
                    NavigationLink("Uložené adresy") {
                        AccountSavedDetailsView()
                    }
                    NavigationLink("Podpora") {
                        SupportView()
                    }
                }
                
                Section {
                    NavigationLink("Nastavení účtu") {
                        AccountSettingsView()
                    }
                    Button(signingOut ? "Odhlašování..." : "Odhlásit se") {
                        signOut()
                    }
                    .foregroundColor(.red)
                }
            }
        }
        .background(Color("BackgroundColor"))
    }
}

// MARK: Functions
extension AccountDashboardView {
    
    func signOut() {
        signingOut = true
        Task {
            do {
                try await userManager.signOut()
            } catch {
                print("Error signout")
            }
            
            DispatchQueue.main.async {
                self.signingOut = false
            }
        }
    }
}

struct AccountDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDashboardView()
            .preferredColorScheme(.dark)
    }
}
