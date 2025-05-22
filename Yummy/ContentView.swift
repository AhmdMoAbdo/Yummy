//
//  ContentView.swift
//  Yummy
//
//  Created by Ahmed on 21/08/2023.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Drawing Initial View
    var body: some View {
        MainTabbarView()
            .onAppear {
                UISegmentedControl.appearance().selectedSegmentTintColor = .orange
                UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16, weight: .semibold)], for: .selected)
            }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
