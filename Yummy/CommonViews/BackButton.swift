//
//  BackButton.swift
//  Yummy
//
//  Created by Ahmed on 28/08/2023.
//

import SwiftUI

struct BackButton: View {
    let topPadding = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets.top
    var color: Color
    var body: some View {
        Image(systemName: "chevron.backward.circle.fill")
            .resizable()
            .frame(width: 40,height: 40)
            .foregroundColor(color)
            .padding(EdgeInsets(top: topPadding ?? 0.0 > 25 ? 59 : 24, leading: 16, bottom: 0, trailing: 0))
    }
}
