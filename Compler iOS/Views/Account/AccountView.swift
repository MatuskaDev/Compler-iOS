//
//  AccountView.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 29.12.2022.
//

import SwiftUI

/// Entry user account view
struct AccountView: View {
    
    @ObservedObject var userManager = UserManager.shared
    
    var body: some View {
        if userManager.isSignedIn() {
            AccountDashboardView()
        } else {
            AccountLoginView()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
