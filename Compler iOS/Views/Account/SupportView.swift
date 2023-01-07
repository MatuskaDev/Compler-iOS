//
//  SupportView.swift
//  Compler iOS
//
//  Created by Lukáš Matuška on 07.01.2023.
//

import SwiftUI

struct SupportView: View {
    var body: some View {
        ColoredList {
            LabeledSection("Pomoc s objednávkami") {
                Link("objednavky@compler.cz", destination: URL(string: "mailto:objednavky@compler.cz")!)
            }
            LabeledSection("Pomoc se zákaznickým účtem") {
                Link("ucty@compler.cz", destination: URL(string: "mailto:ucty@compler.cz")!)
            }
            LabeledSection("Vrácení a reklamace") {
                Link("reklamace@compler.cz", destination: URL(string: "mailto:reklamace@compler.cz")!)
            }
            LabeledSection("Všeobecné dotazy") {
                Link("info@compler.cz", destination: URL(string: "mailto:info@compler.cz")!)
            }
        }
        .navigationTitle("Podpora")
    }
}

struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
            .preferredColorScheme(.dark)
    }
}
