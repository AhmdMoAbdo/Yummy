//
//  IngredientsView.swift
//  Yummy
//
//  Created by Ahmed on 28/08/2023.
//

import SwiftUI
import Kingfisher

struct IngredientsSection: View {
    // MARK: - UI State(s)
    @State var tiles = true
    var ingredients: [MealIngredient]
    
    // MARK: - Drawing view
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            makeSectionHeader()
            makeIngreitents()
        }
    }
    
    // MARK: - Header
    private func makeSectionHeader() -> some View {
        MealDetailsSectionHeader(
            title: Constants.MealDetails.ingredients,
            imageName: Constants.Images.mealDetailsIngredientsSectionIcon,
            trailingImage: tiles ? Constants.Images.mealDetailsIngredientsListIcon : Constants.Images.mealDetailsIngredientsGridIcon
        ) {
            withAnimation {
                tiles.toggle()
            }
        }
    }
    
    // MARK: - Ingredients list
    @ViewBuilder
    private func makeIngreitents() -> some View {
        if tiles {
            makeIngredientsScrollingTiles()
        } else {
            makeIngredientList()
        }
    }
    
    // MARK: - Horizontal Scrolling tiles
    private func makeIngredientsScrollingTiles() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(
                rows: [GridItem(.flexible(), spacing: 12), GridItem(.flexible())],
                spacing: 12
            ) {
                ForEach(ingredients) { ingredient in
                    IngredientTileCell(ingredient: ingredient)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .animation(nil, value: 0)
        }
    }
    
    // MARK: - Vertical Ingredients List
    private func makeIngredientList() -> some View {
        VStack(spacing: 8) {
            ForEach(ingredients) { ingredient in
                makeIngredientListCell(ingredient)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .shadow(radius: 5)
    }
    
    // MARK: - Ingredient vertical list cell
    private func makeIngredientListCell(_ ingredient: MealIngredient) -> some View {
        HStack{
            Image(systemName: Constants.Images.mealDetailsIngredientsListCellIcon)
                .resizable()
                .frame(width: 15,height: 10)
                .foregroundColor(.orange)
            
            Text("\(ingredient.ingredientName) - \(ingredient.amount)")
                .font(.system(size: 16, weight: .medium))
            Spacer()
        }
    }
}
