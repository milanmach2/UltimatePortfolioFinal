//
//  Binding-OnChange.swift
//  UltimatePortfolioFinal
//
//  Created by Milan Mach on 15.01.2023.
//

import SwiftUI
extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}
