//
//  IngredientTileCell.swift
//  Yummy
//
//  Created by Ahmed Abdo on 16/04/2025.
//

import SwiftUI
import Kingfisher

struct IngredientTileCell: View {
    // MARK: - Properties
    var ingredient: MealIngredient
    
    // MARK: - Drawing view
    var body: some View {
        ZStack(alignment:.bottom) {
            makeBackgroundImage()
            makeIngredientDetails()
        }
        .frame(width: 125, height: 150)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
    
    // MARK: - Background Image
    private func makeBackgroundImage() -> some View {
        KFImage(URL(string: ingredient.thumbnail))
            .resizable()
            .scaledToFit()
            .frame(width: 100,height: 150)
    }
    
    // MARK: - Bottom ingredient details
    private func makeIngredientDetails() -> some View {
        VStack {
            Text(ingredient.ingredientName)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
            
            Text(ingredient.amount)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.white)
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.5))
    }
}
