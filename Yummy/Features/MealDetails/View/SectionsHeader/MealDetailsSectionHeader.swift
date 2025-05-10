//
//  MealDetailsSectionHeader.swift
//  Yummy
//
//  Created by Ahmed Abdo on 16/04/2025.
//

import SwiftUI

struct MealDetailsSectionHeader: View {
    // MARK: - Properties
    var title: String
    var imageName: String
    var trailingImage: String?
    var trailingImageClickAction: (() -> Void)?
    
    // MARK: - Drawing view
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 23, height: 23)
                .foregroundColor(.black)
            
            Text(title)
                .font(.system(size: 18, weight: .bold))
            
            Spacer()
            
            if let trailingImage {
                Button {
                    trailingImageClickAction?()
                } label: {
                    Image(systemName: trailingImage)
                        .foregroundStyle(.black)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Preview
#Preview {
    MealDetailsSectionHeader(title: "", imageName: "")
}
