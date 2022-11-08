//
//  Compler_iOSApp.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 08.11.2022.
//

import SwiftUI
import FirebaseCore

@main
struct Compler_iOSApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
        }
    }
}
