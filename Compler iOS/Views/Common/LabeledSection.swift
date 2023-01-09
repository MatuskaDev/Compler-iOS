//
//  LabeledSection.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 07.01.2023.
//

import SwiftUI

/// List section with labeled vstack
struct LabeledSection<Content: View>: View {
    var label: String
    var content: Content
    
    init(_ label: String, @ViewBuilder content: () -> Content) {
        self.label = label
        self.content = content()
    }
    
    var body: some View {
        Section {
            VStack(alignment: .leading) {
                Text(label)
                content
            }
        }
    }
}

struct LabeledSection_Previews: PreviewProvider {
    static var previews: some View {
        LabeledSection("Lavel") {
            
        }
    }
}
