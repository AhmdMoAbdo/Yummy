//
//  BackButton.swift
//  Yummy
//
//  Created by Ahmed on 28/08/2023.
//

import SwiftUI

struct BackButton: View {
    // MARK: - Properties
    let topSafeArea = Shortcuts.window?.safeAreaInsets.top ?? 0.0
    var color: Color
    var buttonAction: () -> Void
    
    // MARK: - Drawing View
    var body: some View {
        HStack {
            Button {
                buttonAction()
            } label: {
                Image(systemName: Constants.Images.backButton)
                    .resizable()
                    .frame(width: 36, height: 36)
                    .foregroundColor(color)
                    .padding(EdgeInsets(top: topSafeArea > 25 ? 59 : 24, leading: 16, bottom: 0, trailing: 0))
            }
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    BackButton(color: .black, buttonAction: {})
}
