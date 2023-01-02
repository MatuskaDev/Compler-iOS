//
//  AccountView.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 29.12.2022.
//

import SwiftUI

struct AccountView: View {
    
    @ObservedObject var userManager = UserManager.shared
    
    var body: some View {
        if userManager.user?.isAnonymous ?? true {
            LoginView()
        } else {
            AccountDashboardView()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
