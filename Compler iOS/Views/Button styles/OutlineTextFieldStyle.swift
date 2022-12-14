//
//  OutlineTextFieldStyle.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 14.12.2022.
//

import SwiftUI

struct OutlineTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white)
            }
    }
}

struct OutlineTextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        TextField("Test", text: .constant(""))
            .textFieldStyle(OutlineTextFieldStyle())
            .preferredColorScheme(.dark)
    }
}
