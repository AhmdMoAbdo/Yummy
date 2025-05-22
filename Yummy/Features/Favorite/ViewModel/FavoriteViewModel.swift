//
//  FavoriteViewModel.swift
//  Yummy
//
//  Created by Ahmed on 27/08/2023.
//

import Foundation

class FavoriteViewModel: BaseViewModel {
    // MARK: - Properties
    @Published var favMeals: [Meal] = []
    @Published var mealToDelete: Meal?
    
    // MARK: - Getting fav meals from DB
    func getFavMeals() {
        favMeals = DBManager.shared.getFavoriteMeals()
    }
    
    // MARK: - Deleting a meal from fav list
    override func deleteMealFromFav(meal: Meal) {
        guard let mealToDelete else { return }
        super.deleteMealFromFav(meal: mealToDelete)
        favMeals.removeAll { $0.strMeal == meal.strMeal }
        self.mealToDelete = nil
    }
}
