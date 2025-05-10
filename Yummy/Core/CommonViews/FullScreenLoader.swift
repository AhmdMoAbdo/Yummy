//
//  FullScreenLoader.swift
//  Yummy
//
//  Created by Ahmed Abdo on 05/05/2025.
//

import SwiftUI

struct FullScreenLoader: View {
    var body: some View {
        VStack {
            Spacer()
            IconAnimation(
                lottieFile: Constants.LottieAnimation.loader,
                animationLoop: .loop
            )
            .frame(width: 200,height: 200)
            .padding(.bottom, 100)
            
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    FullScreenLoader()
}
