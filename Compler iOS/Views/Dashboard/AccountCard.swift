//
//  AccountCard.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 02.01.2023.
//

import SwiftUI

struct AccountCard: View {
    
    @ObservedObject var userManager = UserManager.shared
    
    private var icon: String {
        if userManager.isSignedIn(){
            return "person.crop.circle.badge.checkmark"
        } else {
            return "person.crop.circle.badge.plus"
        }
    }
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40)
            VStack(alignment: .leading) {
                Text(userManager.user?.name ?? "Zákaznický účet")
                    .font(.title2)
                    .bold()
                Text(userManager.user?.email ?? "přihlásit se nebo vytvořit účet")
                    .font(.caption)
            }
            .padding(.trailing)
        }
        .padding()
        .background(Color("SecondaryBG"))
        .cornerRadius(100)
    }
}

struct AccountCard_Previews: PreviewProvider {
    static var previews: some View {
        AccountCard()
            .preferredColorScheme(.dark)
    }
}
