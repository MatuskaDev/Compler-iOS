//
//  ColoredList.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 07.01.2023.
//

import SwiftUI

/// Inset grouped list with background color
struct ColoredList<Content: View>: View {
    @ViewBuilder var content: Content
    var body: some View {
        List {
            content
                .listRowBackground(Color("SecondaryBG"))
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(Color("BackgroundColor"))
        .scrollDismissesKeyboard(.immediately)
    }
}

struct ColoredList_Previews: PreviewProvider {
    static var previews: some View {
        ColoredList {
            
        }
    }
}
