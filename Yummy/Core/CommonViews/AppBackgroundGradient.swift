//
//  AppBackgroundGradient.swift
//  Yummy
//
//  Created by Ahmed Abdo on 20/04/2025.
//

import SwiftUI

struct AppBackgroundGradient: View {
    var body: some View {
        LinearGradient(
            colors: [.gray.opacity(0.3),.white],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea(.all)
    }
}

// MARK: - Preview
#Preview {
    AppBackgroundGradient()
}
