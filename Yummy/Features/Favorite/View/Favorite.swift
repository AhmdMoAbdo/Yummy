//
//  Favorite.swift
//  Yummy
//
//  Created by Ahmed on 25/08/2023.
//

import SwiftUI

struct Favorite: View {
    // MARK: - Properties
    @StateObject var viewModel = FavoriteViewModel()
    @State var alertPresented = false
    
    // MARK: - Drawing View
    var body: some View {
        ZStack {
            AppBackgroundGradient()
            VStack(spacing: 8) {
                PageHeader(
                    pageTitle: Constants.Favorite.pageHeader,
                    animationName: Constants.LottieAnimation.favorite,
                    animationSize: CGSize(width: 35, height: 35)
                )
                if viewModel.favMeals.isEmpty {
                    EmptyStateView(
                        imageName: Constants.Images.weekPlanEmptyState,
                        message: Constants.WeekPlan.emptyStateMessage
                    )
                } else {
                    makeFavoriteMealsList()
                }
            }
            .toolbar(.hidden, for: .navigationBar, .tabBar)
            .ignoresSafeArea(.all, edges: .bottom)
            .onAppear{
                viewModel.getFavMeals()
            }
        }
    }
    
    // MARK: - Favorites list
    private func makeFavoriteMealsList() -> some View {
        List {
            ForEach(viewModel.favMeals, id: \.idMeal) { meal in
                MealCell(
                    meal: meal,
                    isFav: true
                ) { isFav, meal in
                    viewModel.mealToDelete = meal
                    isFav ? viewModel.addMealToFav(meal: meal) : viewModel.deleteMealFromFav(meal: meal)
                }
                .addListCellDeleteSwipeAction {
                    viewModel.mealToDelete = meal
                    alertPresented = true
                }
                .presentAddOrDeleteMealFromFavAlert(
                    alertPresented: $alertPresented,
                    mealName: viewModel.mealToDelete?.strMeal ?? "",
                    alreadyInFavorites: true
                ) {
                    guard let mealToDelete = viewModel.mealToDelete else { return }
                    viewModel.deleteMealFromFav(meal: mealToDelete)
                    viewModel.mealToDelete = nil
                }
                .stealthListRow()
            }
            
            Color.clear.frame(height: Shortcuts.tabbarHeight)
                .stealthListRow(bottomInset: 16)
        }
        .listStyle(.plain)
        .listRowSpacing(8)
        .scrollIndicators(.never)
    }
}

// MARK: - Preview
#Preview {
    Favorite()
}
