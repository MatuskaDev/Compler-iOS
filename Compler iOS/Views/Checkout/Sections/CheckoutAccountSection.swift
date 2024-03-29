//
//  CheckoutAccountSection.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 02.01.2023.
//

import SwiftUI

struct CheckoutAccountSection: View {
    
    @ObservedObject private var userManager = UserManager.shared
    @State private var showLoginSheet = false
    
    var body: some View {
        LabeledVStack("Compler účet") {
            Text("sledujte svou objednávku a uložte si údaje na příště.")
            
            if userManager.isSignedIn(){
                // User badge
                HStack {
                    Spacer()
                    Image(systemName: "person.crop.circle.badge.checkmark")
                    Text(userManager.user?.name ?? "Přihlášený uživatel")
                    Spacer()
                }
                .padding()
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(8)
            } else {
                // Login button
                Button {
                    showLoginSheet.toggle()
                } label: {
                    HStack {
                        Spacer()
                        Image(systemName: "person.crop.circle.badge.plus")
                        Text("Přihlásit se nebo vytvořit nový účet")
                        Spacer()
                    }
                }
                .buttonStyle(OutlineButtonStyle(isSelected: false))
            }
        }
        .sheet(isPresented: $showLoginSheet) {
            AccountLoginView()
        }
        .onChange(of: userManager.isSignedIn()) { newValue in
            showLoginSheet = false
        }
    }
}

struct CheckoutAccountSection_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutAccountSection()
            .preferredColorScheme(.dark)
    }
}
