//
//  AccountDashboardView.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 02.01.2023.
//

import SwiftUI

struct AccountDashboardView: View {
    
    @ObservedObject var userManager = UserManager.shared
    @ObservedObject var model = AccountViewModel()
    
    var body: some View {
        VStack(spacing: 15) {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                Text("Compler účet")
                    .font(.title.bold())
            }
            
            VStack {
                if let name = userManager.user?.name {
                    Text(name)
                        .bold()
                }
                if let email = userManager.user?.email {
                    Text(email)
                }
            }
            
            List {
                NavigationLink("Historie objednávek") {
                    OrderHistoryView()
                }
                .listRowBackground(Color("SecondaryBG"))
                
                Section {
                    NavigationLink("Uložené adresy") {
                        AccountSavedDetailsView()
                    }
                    NavigationLink("Podpora") {
                        
                    }
                }
                
                .listRowBackground(Color("SecondaryBG"))
                
                Section {
                    NavigationLink("Nastavení účtu") {
                        //
                    }
                    Button(model.signingOut ? "Odhlašování..." : "Odhlásit se") {
                        model.signOut()
                    }
                    .foregroundColor(.red)
                }
                .listRowBackground(Color("SecondaryBG"))
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
        }
        .background(Color("BackgroundColor"))
    }
}

struct AccountDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDashboardView()
            .preferredColorScheme(.dark)
    }
}
