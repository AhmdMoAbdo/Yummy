//
//  StealthListRow.swift
//  Yummy
//
//  Created by Ahmed Abdo on 05/05/2025.
//

import SwiftUI

extension View {
    public func stealthListRow(bottomInset: CGFloat = 0) -> some View {
        modifier(StealthListRow(bottomInset: bottomInset))
    }
}

struct StealthListRow: ViewModifier {
    var bottomInset: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: bottomInset, trailing: 0))
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
    }
}
